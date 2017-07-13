From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [rtc-linux] Re: [PATCH] RTC: Add functionality to read/write rtc
 scratch registers
Date: Thu, 13 Jul 2017 22:43:55 +0200
Message-ID: <20170713204355.sbtjip5skms6zwdq@piout.net>
References: <1492492807-20316-1-git-send-email-j-keerthy@ti.com>
 <8b28ca13-9822-4172-95b0-59802187ec93@ti.com>
 <20170504223827.l56sbaozuarq5xwi@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170504223827.l56sbaozuarq5xwi@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 05/05/2017 at 00:38:27 +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 03/05/2017 at 11:39:34 +0530, Keerthy wrote:
> > On Tuesday 18 April 2017 10:50 AM, Keerthy wrote:
> > > From: Russ Dill <Russ.Dill@ti.com>
> > > 
> > > Many RTCs provide scratch registers that are maintained so long as the RTC
> > > has power. Provide a generic method to access these registers.
> > > 
> > 
> > A gentle ping on this
> > 
> 
> Yeah, I apologize for the delay (I know you already sent this 6-8 months
> ago).
> I'm not satisfied with the interface (and its name). I gave a lot of
> thought into it and I'm currently reworking part of the subsystem to
> create a similar feature. I'm planning to have it in 4.13.
> 

So, the nvmem stuff is now in 4.13. If you can still wait a bit, I'll
implement it myself and test on am335x.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
