From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Update Nanobone dts file to add external FRAM chip
Date: Thu, 5 Jan 2017 09:09:32 -0800
Message-ID: <20170105170932.GJ4310@atomide.com>
References: <3e63c74c-1808-46bd-4c63-5ea049cca4e2@newflow.co.uk>
 <4a2e83f2-64ed-df2b-947a-548df60f203b@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4a2e83f2-64ed-df2b-947a-548df60f203b@newflow.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Mark Jackson <mpfj-list@newflow.co.uk> [170104 02:56]:
> On 15/12/16 10:52, Mark Jackson wrote:
> >>From v4.2+ the GPMC code has been changed to reset all the bootloader
> > GPMC settings when the kernel starts.
> > 
> > As such, this DTS file now needs the external FRAM defined.
> > 
> > Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
> 
> <snip>
> 
> Tony, any update on this patch ?

Applying into omap-for-v4.11/dt thanks. I usually don't get around to
applying new stuff until around -rc2 or after the fixes are out of
the way. And then I usually don't apply much anything except fixes
after -rc6 FYI.

Regards,

Tony
