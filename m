From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:53:33 +0100
Message-ID: <20100527205333.676ad65e@lxorguk.ukuu.org.uk>
References: <20100527140655.GA28048@srcf.ucam.org>
	<20100527160543.2228fc17@lxorguk.ukuu.org.uk>
	<20100527160714.GB31937@srcf.ucam.org>
	<20100527174131.18fd1c72@lxorguk.ukuu.org.uk>
	<20100527165210.GA1062@srcf.ucam.org>
	<20100527190204.14546caa@lxorguk.ukuu.org.uk>
	<20100527181239.GF3543@srcf.ucam.org>
	<20100527194840.5bca973f@lxorguk.ukuu.org.uk>
	<20100527185658.GA5703@srcf.ucam.org>
	<20100527202538.7d2d7f3c@lxorguk.ukuu.org.uk>
	<20100527192926.GA6977@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527192926.GA6977@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Arve =?ISO-8859-14?B?SGr4bm5lduVn?= <arve@android.com>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010 20:29:26 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, May 27, 2010 at 08:25:38PM +0100, Alan Cox wrote:
> 
> > The scheduler can happily do this, the power management will also
> > recognize STOPPED processes as no impediment to suspend.
> 
> But wakeup events won't be delivered to STOPped processes, and there's 

Try the following

	cat <pipe
	kill -STOP catpid

	echo "wombats are cool" > pipe
	kill -CONT catpid

it will echo "wombats are cool"

The event was not lost.

> also the race of an application being in the middle of handling a wakeup 
> event when you send it the signal.

sigmask()
