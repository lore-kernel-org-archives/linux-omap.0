From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Wed, 15 Oct 2014 22:25:13 +0100
Message-ID: <20141015212513.GA3247@n2100.arm.linux.org.uk>
References: <20141009204101.GA25955@debian>
 <20141009204637.GE25729@saruman>
 <20141009210715.GH25729@saruman>
 <20141010135743.GB31348@saruman>
 <20141010162531.GL12379@n2100.arm.linux.org.uk>
 <54388B81.5020306@mentor.com>
 <063D6719AE5E284EB5DD2968C1650D6D174C996E@AcuExch.aculab.com>
 <20141013114307.GO12379@n2100.arm.linux.org.uk>
 <20141014020640.GB25433@kroah.com>
 <20141015212310.GP12379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141015212310.GP12379-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>, 'Nathan Lynch' <Nathan_Lynch-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org" <josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org>, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Johannes Weiner <hannes-druUgvl0LCNAfugRpC6u6w@public.gmane.org>, Sasha Levin <sasha.levin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 15, 2014 at 10:23:10PM +0100, Russell King - ARM Linux wrote:
> As I said, I have a patch in progress, but it seems that there needed
> to be some discussion about exactly which compiler versions are affected.
> It seems that it's not as trivial as looking at the GCC bug entry.

... and in any case, it has been a known bug for well over a year now,
and it seems that it doesn't affect _that_ many people.  So taking some
extra time to get it properly correct is the _right_ thing to do.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
