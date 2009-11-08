From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 1/1] PM: Thaws refrigerated and to be exited kernel
 threads
Date: Sun, 8 Nov 2009 16:30:40 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE31FD0F@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE31F934@dbde02.ent.ti.com>
 <20091107165421.GA1630@ucw.cz>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE31FCF1@dbde02.ent.ti.com>
 <20091108082727.GC16482@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60050 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbZKHLBz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Nov 2009 06:01:55 -0500
In-Reply-To: <20091108082727.GC16482@elf.ucw.cz>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>



> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Sunday, November 08, 2009 1:57 PM
> To: Dasgupta, Romit
> Cc: Rafael J. Wysocki; linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-pm@lists.linux-foundation.org
> Subject: Re: [PATCH 1/1] PM: Thaws refrigerated and to be exited kernel threads
> 
> On Sun 2009-11-08 09:52:52, Dasgupta, Romit wrote:
> > > Subject: Re: [PATCH 1/1] PM: Thaws refrigerated and to be exited kernel
> > > threads
> > >
> > > Hi!
> > >
> > > > Kicks out a frozen thread from the refrigerator when an active thread has
> > > > invoked kthread_stop on the frozen thread.
> ...
> > > > @@ -49,7 +50,7 @@ void refrigerator(void)
> > > >
> > > >  	for (;;) {
> > > >  		set_current_state(TASK_UNINTERRUPTIBLE);
> > > > -		if (!frozen(current))
> > > > +		if (!frozen(current) || (!current->mm &&
> kthread_should_stop()))
> > > >  			break;
> > > >  		schedule();
> > >
> > > Well, what if the thread does some processing before stopping? That
> > > would break refrigerator assumptions...
> >
> > The suspend thread will block until the 'to be stopped' thread clears up. That is
> what any call to kthread_stop would boil down to. The target thread would
> anyway be out of the refrigerator so I am not sure what assumption you mean
> here. Eventually, the target thread would clear up and wake up the suspend
> thread and then things would go on as usual.
> 
> (Please format to 80 columns).
> 
> No, I do not get it.
> 
> Lets say we have
> 
> evil_data_writer thread that needs to be stopped becuase it writes to
> filesystem
> 
> nofreeze random_stopper thread
> 
> now we create the suspend image, and start writing it out. But that's
> okay, evil_data_writer is stopped so it can't do no harm. But now
> random_stopper decides to thread_stop() the evil_data_writer, and this
> new code allows it to exit the refrigerator, *do some writing*, and
> then stop.
> 
> That's bad, right?

evil_data_writer will enter refrigerator after invoking 'try_to_freeze'. This should be followed by a call to kthread_should_stop. There it decides if it needs to exit the thread (after cleanups if necessary) or not. I have seen that the bdi_writeback_task function is like that. It does not care if there is pending data to be written if it detects that someone have invoked a 'kthread_stop' on it. It simply exits. I have seen some other kernel threads that do not follow this and I think that probably is not right. 
