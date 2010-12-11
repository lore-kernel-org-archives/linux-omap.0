From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add omap_device latency information
Date: Sat, 11 Dec 2010 09:25:34 -0600
Message-ID: <AANLkTi=cQVr-T1mJeq9uaRn5VyXxBG-xcp79z898E6nx@mail.gmail.com>
References: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>
	<1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 10, 2010 at 7:51 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> So that we can enable the main clock.

This should be:

Subject: OMAP: mailbox: use runtime pm for clk and sysc handling

Use runtime pm APIs to enable/disable mailbox clocks and to configure
SYSCONFIG registers.

And if someone agrees, device_latency can be merged with the previous
patch for device_build. I'll wait for comments and resubmit.

Regards,

Omar
