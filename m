From: Tony Lindgren <tony@atomide.com>
Subject: Re: Minimal support for dm814x
Date: Fri, 13 Nov 2015 06:57:40 -0800
Message-ID: <20151113145740.GE2517@atomide.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
 <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
 <20151111174028.GF3218@atomide.com>
 <CAALWOA_dEtajQBLrXesQ2bRCDf-1Dzg_tJw_=yAmaO=T3=KMZQ@mail.gmail.com>
 <20151112174155.GM3218@atomide.com>
 <CAALWOA9o80rhaqwaa6=XxmNN1FcWzHDXiaqkqFVO81CAMX=04w@mail.gmail.com>
 <CAALWOA-29pK=GbNKhdY=4oJzhnueVxNAPruu9Uacqi5vMJN=OA@mail.gmail.com>
 <20151113145216.GC2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151113145216.GC2517@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Delio Brignoli <dbrignoli@audioscience.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [151113 06:53]:
> * Matthijs van Duin <matthijsvanduin@gmail.com> [151113 03:00]:
> > On 13 November 2015 at 08:14, Matthijs van Duin
> > <matthijsvanduin@gmail.com> wrote:
> > > It seems this is how the old TI kernel handles them: http://goo.gl/3I3OEL
> > 
> > Never mind, wasn't paying attention and managed to overlook that
> > google had found me the u-boot tree instead of the kernel tree I
> > intended to search for. -.-
> > 
> > Sorry about that, when I find a moment I'll locate the correct files
> > and check those.
> 
> I think this is the most recent TI git repo for dm81xx changes:
> 
> http://arago-project.org/git/projects/?p=linux-omap3.git;a=summary
> git://arago-project.org/git/projects/linux-omap3.git

Oh and the adpll code is under arch/arm/mach-omap2 in that kernel:

http://arago-project.org/git/projects/?p=linux-omap3.git;a=blob;f=arch/arm/mach-omap2/adpll_ti814x.c;h=27877268f3598f7a253b578674208ab406c44524;hb=HEAD

Regards,

Tony
