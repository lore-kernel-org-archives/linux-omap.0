From: "Wang, Jane" <jwang@ti.com>
Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume
	failure	fix
Date: Fri, 13 Nov 2009 11:52:59 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B9BAA0F@dlee02.ent.ti.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
	(sfid-20091113_173850_761073_9598FCAB)
	<171D41FE-0C40-4921-97FF-B8DE2D360C9A@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <171D41FE-0C40-4921-97FF-B8DE2D360C9A@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
> project.org] On Behalf Of Mark Brown
> Sent: Friday, November 13, 2009 11:49 AM
> To: Wang, Jane
> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org;
> peter.ujfalusi@nokia.com; Wang, Jane
> Subject: Re: [alsa-devel] [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure
> fix
> 
> On 13 Nov 2009, at 17:39, Jane Wang <jwang@ti.com> wrote:
> 
> > McBSP fucntional clock is not disabled when suspend is triggerd which
> > prevents PER domain entering target low-power state. To fix the
> > problem:
> >
> > 1. Disable/enable McBSP functional clock for suspend/resume.
> >
> > 2. In addition, reconfigure McBSP, this is needed when systerm comes
> > out of OFF state.
> >
> 
> There is no need to resend your patches this iften - please allow at
> least a week or so for review. You only need to repost if addressing
> comments or it looks like the patch got missed.
> 

Sorry for sending this again. Something is not set correctly with my
git send-email. The email did not reach the mailing lists, it only reached
people in cc.
