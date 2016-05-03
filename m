From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Bunch of serial warnings in next at least with omap-serial
Date: Tue, 3 May 2016 14:01:51 -0700
Message-ID: <572911BF.8000803@hurleysoftware.com>
References: <20160503203930.GQ5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160503203930.GQ5995@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 05/03/2016 01:39 PM, Tony Lindgren wrote:
> Hi Peter,
> 
> Looks like probably commit 4047b37122d1 ("serial: core: Prevent unsafe
> uart port access, part 1") in Linux next causes tons of warnings with at
> least omap-serial. It does not revert cleanly I have not tested with that
> reverted. Any ideas? Dmesg output of the errors below.

Thanks for the report.
Patch below should fix that.

--- >% ---
Subject: [PATCH] serial: core: Fix port mutex assert if lockdep disabled

commit 4047b37122d1 ("serial: core: Prevent unsafe uart port access,
part 1") added lockdep assertion for port mutex but fails to check
if debug_locks has disabled lockdep (so lock state is no longer
reliable).

Use lockdep_assert_held() instead, which properly checks lockdep
state as well.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0e66923..b88a054 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -95,9 +95,7 @@ static inline void uart_port_deref(struct uart_port *uport)
 
 static inline struct uart_port *uart_port_check(struct uart_state *state)
 {
-#ifdef CONFIG_LOCKDEP
-	WARN_ON(!lockdep_is_held(&state->port.mutex));
-#endif
+	lockdep_assert_held(&state->port.mutex);
 	return state->uart_port;
 }
 
-- 
2.8.2
