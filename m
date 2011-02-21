From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] headers: fix circular dependency between
 linux/sched.h and linux/wait.h
Date: Mon, 21 Feb 2011 16:08:11 +0200
Message-ID: <20110221140811.GH23087@legolas.emea.dhcp.ti.com>
References: <1298283649-24532-1-git-send-email-dacohen@gmail.com>
 <1298283649-24532-2-git-send-email-dacohen@gmail.com>
 <AANLkTimwvgLvpvndCqcd_okA2Kk4cu7z4bD3QXTdgWJW@mail.gmail.com>
 <20110221123049.GC23087@legolas.emea.dhcp.ti.com>
 <AANLkTinc=ye2qZJ1esSta=xEGz_iEr73eg3qEES2S5P7@mail.gmail.com>
 <20110221135709.GG23087@legolas.emea.dhcp.ti.com>
 <AANLkTin6SY6oUd8j3dcvjoTrPn4P2XP=hX5S+D8s1J+g@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTin6SY6oUd8j3dcvjoTrPn4P2XP=hX5S+D8s1J+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: balbi@ti.com, Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Feb 21, 2011 at 04:05:14PM +0200, David Cohen wrote:
> On Mon, Feb 21, 2011 at 3:57 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Mon, Feb 21, 2011 at 03:51:25PM +0200, Alexey Dobriyan wrote:
> >> > I rather have the split done and kill the circular dependency.
> >>
> >> It's not circular for starters.
> >
> > how come ? wait.h depends on sched and sched.h depends on wait.h
> 
> The tricky thing is wait.h doesn't depend on sched.h, but the file
> which uses wake_up*() macro defined on wait.h will depend on sched.h
> (what is still bad). wait.h should provide all dependencies to use a

That's why I say wait.h depends on sched.h because it uses a macro
defined in sched.h

-- 
balbi
