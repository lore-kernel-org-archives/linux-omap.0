From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 00:27:01 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006010023220.2933@localhost.localdomain>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<1275149418.4503.128.camel@mulgrave.site>
	<alpine.LFD.2.00.1005312250050.2933@localhost.localdomain>
	<201006010024.00032.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006010024.00032.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, 1 Jun 2010, Rafael J. Wysocki wrote:
> On Monday 31 May 2010, Thomas Gleixner wrote:
> > So that allows to use the same mechanism for more than the android
> > sledge hammer approach and confines the controversial use cases into
> > android specific files without adding a hard to maintain user space
> > interface which would prevent or at least make it hard to do some of
> > the above mentioned things which we want to see implemented.
> 
> I generally agree.
> 
> I think the Alan Stern's recent proposal goes along these lines, but it has
> the advantage of being a bit more specific. ;-)

Yes, Alan Stern's proposal is going into that direction and I'm not
opposed. Just wanted to get the overall picture straight for James :)

Thanks,

	tglx
