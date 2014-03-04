From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/5] drivers: bus: omap_l3: Convert to use devm_kzalloc
Date: Tue, 4 Mar 2014 11:07:52 +0200
Message-ID: <531597E8.50509@ti.com>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
 <1393923710-10377-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393923710-10377-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/04/2014 11:01 AM, Peter Ujfalusi wrote:
> We can remove the kfree() calls from probe and remove.
> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti>

Where did the ".com" went from Santosh's email address??
I'll resend it in a minute with a fixed commit message.

-- =

P=E9ter
