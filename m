From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 14:02:36 +0100
Message-ID: <20100528140236.3214929e@lxorguk.ukuu.org.uk>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
	<20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
	<AANLkTilYHKKmQePBGW3LVLjUZy7HXHQku2Iub-LWGBm6@mail.gmail.com>
	<20100528132138.2d802d77@lxorguk.ukuu.org.uk>
	<1275049836.1645.1.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275049836.1645.1.camel@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arve =?ISO-8859-14?B?SGr4bm5lduVn?= <arve@android.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 28 May 2010 14:30:36 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2010-05-28 at 13:21 +0100, Alan Cox wrote:
> > [Total kernel changes
> > 
> >         Ability to mark/unmark a scheduler control group as outside of
> >         some parts of idle consideration. Generically useful and
> >         localised. Group latency will do most jobs fine (Zygo is correct
> >         it can't solve his backup case elegantly I think)
> > 
> >         Test in the idling logic to distinguish the case and only needed
> >         for a single Android specific power module. Generically useful
> >         and localised] 
> 
> I really don't like this..
> 
> Why can't we go with the previously suggested: make bad apps block on
> QoS resources or send SIGXCPU, SIGSTOP, SIGTERM and eventually SIGKILL

Ok. Are you happy with the QoS being attached to a scheduler control
group and the use of them to figure out what is what ?
