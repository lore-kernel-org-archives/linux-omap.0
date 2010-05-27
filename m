From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 21:03:33 +0100
Message-ID: <20100527210333.4b09dfe2@lxorguk.ukuu.org.uk>
References: <AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
	<20100527003943.07c17f85@lxorguk.ukuu.org.uk>
	<20100527140655.GA28048@srcf.ucam.org>
	<alpine.LFD.2.00.1005271642440.3032@localhost.localdomain>
	<20100527155201.GA31937@srcf.ucam.org>
	<alpine.LFD.2.00.1005271808340.3032@localhost.localdomain>
	<20100527165931.GB1062@srcf.ucam.org>
	<alpine.LFD.2.00.1005271905000.3032@localhost.localdomain>
	<20100527172343.GB2468@srcf.ucam.org>
	<alpine.LFD.2.00.1005271930350.3032@localhost.localdomain>
	<20100527182633.GN3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527182633.GN3543@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

> We were talking about PCs. Suspend-as-c-state is already implemented for 
> OMAP.

"You" were talking about PCs. Some of us are interested in the making
Linux do the right thing not adding platform specific hacks all over the
userspace of all the apps.
 
> > So the only thing you are imposing to app writers is to use an
> > interface which solves nothing and does not save you any power at
> > all. 
> 
> It's already been demonstrated that the Android approach saves power.

So do lots of other things

> > Runnable tasks and QoS guarantees are the indicators whether you can
> > go to opportunistic suspend or not. Everything else is just window
> > dressing.
> 
> As I keep saying, this is all much less interesting if you don't care 
> about handling suboptimal applications. If you do care about them then 

I don't believe the Android one does either. It maybe handles a subset in
a specific case.

> the Android approach works. Nobody has demonstrated a scheduler-based 
> one that does.

I would point you at the web, cgi scripts and the huge Linux server farms
fielding billions of hits per second on crap cgi scripts.

That doesn't mean the Android one is the right approach. Nobody has
explained to me how you don't get synchronization effects in Android or
indeed answered several of the questions pointing out holes in the
Android model. The fact we are at rev 8 says something too - that the
Android 'proof' isn't old or tested either !

Alan
