From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 17/18] OMAP4: hwmod data: Modify DSS opt clocks
Date: Sat, 9 Jul 2011 02:26:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107090224410.15984@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<1309552901-8944-18-git-send-email-b-cousson@ti.com>
	<1309598037.1846.3.camel@deskari>
	<1309599388.1846.12.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309599388.1846.12.camel@deskari>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, 2 Jul 2011, Tomi Valkeinen wrote:

> Even after removing the "fck"s from the hwmod data, I see:
> 
> [    0.218200] omap_device: omapdss_dss: fck already exist
> [    0.218231] omap_device: omapdss_dss: sys_clk already exist
> [    0.218231] omap_device: omapdss_dss: tv_clk already exist
> [    0.218292] omap_device: omapdss_dss: video_clk already exist
> 
> I think those come from the clock44xxx_data.c. I believe those are more
> or less exact duplicates from the driver's point of view? If so, I guess
> the ones in clockdata could be removed after adding those to hwmod data?

I've removed these too.


thanks,

- Paul
