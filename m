From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:18:33 +0300
Message-ID: <20100527171833.GD9625@nokia.com>
References: <20100526142430.327ccbc4@schatten.dmk.lab>
 <20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
 <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
 <20100527003943.07c17f85@lxorguk.ukuu.org.uk>
 <20100527140655.GA28048@srcf.ucam.org>
 <alpine.LFD.2.00.1005271642440.3032@localhost.localdomain>
 <20100527155201.GA31937@srcf.ucam.org>
 <20100527171615.15a1fd3d@lxorguk.ukuu.org.uk>
 <20100527161943.GA32764@srcf.ucam.org>
 <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005271901020.3032@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, May 27, 2010 at 07:04:38PM +0200, ext Thomas Gleixner wrote:
>Opportunistic suspend is just a deep idle state, nothing else. If the
>overall QoS requirements allow to enter that deep idle state then the
>kernel goes there. Same decision as for all other idle states. You
>don't need any user space blocker for this decision, just sensible QoS
>information.

agree completely with you. Adding virtual differences between power 
states is a bad idea and causes unnecessary complication to the system. 
If we have a generic way of describing desired latencies (irq, wakeup, 
throughput, whatever), then the kernel should decide what's the best 
power state for the current situation.

-- 
balbi

DefectiveByDesign.org
