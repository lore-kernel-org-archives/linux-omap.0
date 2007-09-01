From: David Brownell <david-b@pacbell.net>
Subject: Re: MUSB: unreliable OTG detection in host mode
Date: Fri, 31 Aug 2007 19:14:39 -0700
Message-ID: <20070901021439.D617B235164@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <46D8ACD1.8030101@mvista.com>
	<20070901002025.B8E79235120@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<46D8B24F.3010409@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <46D8B24F.3010409@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: khilman@mvista.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > Unreliable in what way(s)?
>
> Meaning it sometimes detects connected devices and sometimes not.
> Sometimes a reboot and another try helps.  But with recent git it seems
> to never detect devices.

What do you mean "detect" though?  Does it not see anything
hooked up to the root hub?  Or once it sees something, is there
some difficulty talking to it?  The specifics will say just where
the problem lies...


> > DaVinci didn't seem to have any such issues...
>
> I haven't tested DaVinci in OTG mode since on the EVM board I have, you
> have to move a jumper to switch between the two.

And when taking the jumper out, you need to wait 30+ seconds for
that capacitor to discharge.

Right, the jumper is just doing what the (missing) ID pin detect IRQ
should have been able to do.  Hook up the jumper, it assumes host role
just as if the A end of a cable was attached and ID grounded.  Remove it,
it assumes peripheral role just as if the B end of the cable were attached
with ID floating.

That's exactly what OTG does ... but it's ultra-slow since you'e got to
fake the connector signaling.  I haven't tried doing the HNP stuff with
DaVinci, but that's not the part of OTG that matters except when you do
conformance testing.

- Dave
