From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCHv2 0/5] staging: omap-thermal fixes
Date: Tue, 13 Nov 2012 16:09:02 -0400
Message-ID: <20121113200902.GA22185@besouro>
References: <1352830204-21546-1-git-send-email-eduardo.valentin@ti.com>
Reply-To: <eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352830204-21546-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: gregkh@linuxfoundation.org, b-cousson@ti.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ndec13@gmail.com
List-Id: linux-omap@vger.kernel.org

Hello,

On Tue, Nov 13, 2012 at 02:09:59PM -0400, Eduardo Valentin wrote:
> Hello again Greg,
> 
> So here is the correct set of changes. They now include the
> right version of the patches and with the fixes reported
> by Enric. Thanks Enric for the heads up.
> 
> So, Several compilation fixes and a couple of debugging prints
> added to the omap-thermal driver under staging area.
> 
> Patches are also available here:
> 
> git@gitorious.org:thermal-framework/thermal-framework.git thermal_work/omap/omap-thermal-fixes_3.7

For those interested pulling using http:
https://git.gitorious.org/thermal-framework/thermal-framework.git thermal_work/omap/omap-thermal-fixes_3.7

> 
> 
> Cheers,
> 
> Eduardo Valentin (4):
>   staging: omap-thermal: fix compilation
>   staging: omap-thermal: remove platform data nomenclature
>   staging: omap-thermal: remove freq_clip table
>   staging: omap-thermal: add IRQ debugging messaging
> 
> Radhesh Fadnis (1):
>   staging: omap-thermal: fix context restore function
> 
>  drivers/staging/omap-thermal/omap-bandgap.c        |   63 ++++++++----------
>  drivers/staging/omap-thermal/omap-bandgap.h        |    9 ---
>  drivers/staging/omap-thermal/omap-thermal-common.c |   69 ++------------------
>  3 files changed, 33 insertions(+), 108 deletions(-)
> 
> -- 
> 1.7.7.1.488.ge8e1c
> 
