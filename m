From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 17:07:14 +0100
Message-ID: <20100527160714.GB31937@srcf.ucam.org>
References: <20100526120242.5c9b73ad@schatten.dmk.lab> <AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com> <20100526133721.602633b2@schatten.dmk.lab> <AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com> <20100526142430.327ccbc4@schatten.dmk.lab> <20100526141612.3e2e0443@lxorguk.ukuu.org.uk> <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com> <20100527003943.07c17f85@lxorguk.ukuu.org.uk> <20100527140655.GA28048@srcf.ucam.org> <20100527160543.2228fc17@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100527160543.2228fc17@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 04:05:43PM +0100, Alan Cox wrote:
> > Now, if the user is playing this game, you want it to be scheduled. If 
> > the user has put down their phone and the screen lock has kicked in, you 
> > don't want it to be scheduled. So we could imagine some sort of cgroup 
> > that contains untrusted tasks - when the session is active we set a flag 
> 
> I would hope not, because I'd rather prefer my app that used the screen
> to get the chance to save important data on what it was doing
> irrespective of the screen blank:  "I have an elegant proof for this
> problem but my battery has gone flat"

Perhaps set after callbacks are made. But given that the approach 
doesn't work anyway...

> What is the problem here - your device driver for the display can block
> tasks it doesn't want to use the display.

It's still racy. Going back to my example without any of the suspend 
blocking code, but using a network socket rather than an input device:

int input = socket(AF_INET, SOCK_STREAM|SOCK_NONBLOCK, 0);
char foo;
struct sockaddr addr;
connect (input, &addr, sizeof(addr))
while (1) {
       if (read(input, &foo, 1) > 0) {
               (do something)
       } else {
               (draw bouncing cows and clouds and tractor beams briefly)
       }
}

A network packet arrives while we're drawing. Before we finish drawing, 
the policy timeout expires and the screen turns off. The app's drawing 
is blocked and so never gets to the point of reading the socket. The 
wakeup event has been lost.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
