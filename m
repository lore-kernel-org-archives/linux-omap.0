From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks
Date: Sun, 6 Aug 2017 18:19:19 +0300
Message-ID: <80dd8051-456b-2331-b847-0631d94f85b1@cogentembedded.com>
References: <20170806151714.108596802@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170806151714.108596802@cogentembedded.com>
Content-Language: en-MW
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/06/2017 06:14 PM, Sergei Shtylyov wrote:

> of_irq_get() may return 0 as well as a nagative error number on failure,

    Oops, forgot to kill comma...

> (and never on success), however omap44xx_prm_late_init() regards 0 as a
> valid IRQ -- fix this.
> 
> Fixes: a8f83aefcd5a ("ARM: OMAP4+: PRM: register interrupt information from DT")
> Fixes: c5b3955828ba ("ARM: OMAP4: Fix legacy code clean-up regression")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

MBR, Sergei
