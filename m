From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] Clean up omap24xx.h symbolic constants
Date: Thu, 17 May 2007 10:43:28 -0700
Message-ID: <20070517174328.GB8556@atomide.com>
References: <20070516225850.075133914@pwsan.com> <464C123F.6050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <464C123F.6050005@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com> [070517 01:29]:
> Hello,
> 
> Paul Walmsley wrote:
> > So, to continue the example above, the OMAP24XX_SDRC_BASE constant
> > will be removed, and replaced with two defines: OMAP2420_SDRC_BASE and
> > OMAP243X_SDRC_BASE.  Depending on which CONFIG_ARCH_OMAP* Kconfig
> > parameter is specified, we then set an SDRC_BASE define to point to
> > one of the two architecture-specific values.
> >
> >   
> IMHO, using of SDRC_BASE as well as CTRL_BASE, PRCM_BASE etc.,
> can lead to name collision, the names is not so unique as may
> seem. I suggest using of OMAP_ prefix for these names.

Good point. We could use OMAP_ prefix and in case of conflicts
with omap1 defines, we could rename them to have OMAP1_ prefix.

Regards,

Tony
