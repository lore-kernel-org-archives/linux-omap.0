From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 23:17:59 +0200
Message-ID: <201005272317.59481.rjw@sisk.pl>
References: <20100526120242.5c9b73ad@schatten.dmk.lab> <1274971437.27810.5078.camel@twins> <20100527161054.203663ca@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527161054.203663ca@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-pm@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, felipe.balbi@nokia.com, List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 27 May 2010, Alan Cox wrote:
> > > Heck, for all I care, simply SIGKILL the thing and report it once the
> > > user starts looking at his screen again.
> > 
> > Provide incentive for Joe Clicker to improve his app, instead of cope
> > with the shit he created.
> 
> That isn't helpful. But if you feel like that I suggest you run with your
> memory management protection disabled, it's really on there to deal with
> crap code and its giving the wrong incentives. Come to think of it
> you might want to remove your seatbelts and any safety catches or airbags
> - it only encourages carelessness.
> 
> The reality is you need a sane, generic, race free way to express your
> requirements (eg for hard RT) and ditto for constraining the expression
> (for 'crapplications')
> 
> Arguing that you don't need to do this isn't useful. Android has
> demonstrated a need to do this. RT has a need to do some of this.
> Virtualisation wants elements of this etc.
> 
> The question is how you do it right.

I violently agree, thanks Alan!

Rafael
