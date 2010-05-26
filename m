From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 12:19:40 +0200
Message-ID: <20100526121940.2edfd531@schatten.dmk.lab>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl>
	<87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl>
	<1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
	<20100526120242.5c9b73ad@schatten.dmk.lab>
	<1274868484.5882.5176.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1274868484.5882.5176.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arve =?ISO-8859-15?B?SGr4bm5lduVn?= <arve@android.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@deeprootsystems.com>, felipe.balbi@nokia.com, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 26 May 2010 12:08:04 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, 2010-05-26 at 12:02 +0200, Florian Mickler wrote:
> > The summary is: The device this kernel is running on dosn't want to
> > (or can) rely on userspace to save power. This is because it is an open
> > system, without an app-store or the like. Everyone can run what he
> > wants.
> > 
> > So anything relying on (all) userspace solves a different problem.
> 
> So what stops an application from grabbing a suspend blocker?

Well, I don't own any android devices, but  If I read this all
correctly, an app can request the permission to grab an suspend blocker
at installation time. ("This application is requesting permission to
keep the device from sleeping, thus possibly reducing your battery
time. Are you shure you want to continue? [Yes,No]")

every app grabbing a suspend blocker is showing
up in a "these programs stop suspend" kind of battery-app and are thus
well accounted for. _And the user knows who to blame_.

Maybe this is implemented via fs-permissions? Anyway, I'm shure,
that the access control uses a well established method. :)  

Cheers,
Flo
