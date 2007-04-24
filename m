From: "Leandro Melo de Sales" <leandroal@gmail.com>
Subject: Re: Compiling latest kernel (from kernel.org,
	linux-omap git version) in n800
Date: Tue, 24 Apr 2007 13:29:55 -0300
Message-ID: <5bc4c4570704240929g4861dd3kc6fd474f1a08aaf6@mail.gmail.com>
References: <5bc4c4570704211518p1168ec99qd8d44fb8f14f5979@mail.gmail.com>
	<5bc4c4570704231129r7bff6759xc97eedc3d8ee26c7@mail.gmail.com>
	<20070423183514.GI19866@intune.research.nokia.com>
	<5bc4c4570704231153p788a3936ue36041eeb7e06f8e@mail.gmail.com>
	<20070423185719.GJ19866@intune.research.nokia.com>
	<5bc4c4570704231216m15565ed0l8e8bb976ac8c0828@mail.gmail.com>
	<5bc4c4570704231239w32060adcq2d026e7956452064@mail.gmail.com>
	<5bc4c4570704231250m34f325b6s45939ffd0a6b28a8@mail.gmail.com>
	<87wt028igg.fsf@nokia.com>
	<5bc4c4570704240856j5e01da7alf16a64ece7ff0b78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <5bc4c4570704240856j5e01da7alf16a64ece7ff0b78@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Kalle,

   It is a bad news! :( Is there a plan to make umac.ko source code
available? And about cx3110x updates, when do you plan to update it?
   What is the latest linux-omap kernel version that it is possible to
compile cx3110x and flash it into n800?

In all case, thank you.
Leandro.

2007/4/24, Kalle Valo <Kalle.Valo@nokia.com>:
> "Leandro Melo de Sales" <leandroal@gmail.com> writes:
>
> > Hi Kalle,
> >
> >  I compiled the omap git kernel version 2.6.21 and flash it into
> > n800. But I can't use my WLAN interface after I compiled.
>
> Currently there's no way to use WLAN interface with 2.6.21. The
> biggest problem is umac.ko, because the sources are not available for
> that module. Also cx3110x needs some updates because of the workqueue
> interface has changed in the kernel.
>
> > Daniel Stone (also from nokia) suggested me to use the cx3110x
> > driver. Please, let me know from now how can I use the driver with
> > my compiled kernel. Daniel suggested me some process, but I don't
> > know how can I do it.
>
> You need to specify few variables for make. Take a look at here for an
> example:
>
> http://maemo.org/pipermail/maemo-developers/2006-August/005368.html
>
> But I admit that cx3110x is badly documented, sorry about that.
>
> BTW, in the future please send your questions to maemo-devel and CC me
> (so that I don't miss it). That way more people can benefit from our
> discussion. I usually don't answer to private questions, but I made an
> exception in this case :)
>
> --
> Kalle Valo
>
