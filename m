From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: N800 UNOFFICIAL USB HOST MODE PATCHES support
Date: Wed, 22 Aug 2007 12:05:41 -0400
Message-ID: <31e679430708220905j7540d965rd03dd15a0d7c3136@mail.gmail.com>
References: <BAY129-W12703188572DA694990DC6E9D50@phx.gbl>
	<31e679430708220752x359e596cwfa1650252e0b5b8d@mail.gmail.com>
	<20070822115045.uawxtkx5xfs4gk40@webmail.caflor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070822115045.uawxtkx5xfs4gk40@webmail.caflor.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "robert.vogt@caflor.net" <robert.vogt@caflor.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 8/22/07, robert.vogt@caflor.net <robert.vogt@caflor.net> wrote:
> Hi,
>
> Would that be v2.6.23-rc3?  The last time I tried to compile a couple versions
> from the git tree, it got build errors.  Is one of these rc versions (or the
> latest version) compiling successfully?  Thanks.

Well, the last time I built linux-omap for n800 and it's working fine.
Which defconfig are you using??

try 'make n800_defconfig && make zImage'

you should get no errors.



>
> -Robert
>
> Quoting Felipe Balbi <felipebalbi@users.sourceforge.net>:
>
> > Hi,
> >
> > On 8/22/07, Baekjae Sung <soma815@msn.com> wrote:
> >>
> >> Hi, All
> >>
> >> I want to use a Wireless USB dongle in n800.
> >>
> >> Does anyone succeed to use a Bluetooth USB dongle or a Wireless USB
> >> dongle in n800??
> >
> > Well, as long as you have the correct patches and kernel modules and
> > (really important) a self-powered usb 2.0 hub, there shouldn't be any
> > trouble about that. But you could try and report us any troubles you
> > happen to find.
> >
> > Please use most recent linux-omap git tree
> >
> >>
> >> Thanks.
> >>
> >> Regards
> >> --- Jay Sung
> >> _________________________________________________________________
> >> Express yourself instantly with MSN Messenger! Download today it's FREE!
> >> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
> >> _______________________________________________
> >> Linux-omap-open-source mailing list
> >> Linux-omap-open-source@linux.omap.com
> >> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >>
> >
> >
> > --
> > Best Regards,
> >
> > Felipe Balbi
> > felipebalbi@users.sourceforge.net
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
