From: Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Unifying cape overlays into boot .dtb for
 BeagleBoard.org boards
Date: Wed, 11 Jun 2014 01:10:38 -0400
Message-ID: <CA+T6QPk_OEMeMb8Ckb0eCn7aO5NoaTx6RuShTBMg+=tOHLA32w@mail.gmail.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=e89a8ff2545011d9dc04fb8877ad
Return-path: <beagleboard+bncBDELZWNUYMHBBT6J36OAKGQESXEA7HQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:googlegroups-manage+1035534660134+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: "beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--e89a8ff2545011d9dc04fb8877ad
Content-Type: text/plain; charset=UTF-8

Adding devicetree and linux-arm-kernel lists based on feedback on IRC...


On Tue, Jun 10, 2014 at 12:46 PM, Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I'd like to discuss moving our current library of cape devicetree
> overlay sources into a single tree, including the boot .dtb files for
> BeagleBoard.org boards and moving towards enabling as much of the cape
> support into a single boot-time .dtb file with an approach similar to
> the cape-universal overlay
> (https://github.com/cdsteinkuehler/beaglebone-universal-io), but not
> in an overlay.
>
> First of all, I want to note this doesn't change my view on the
> importance of mainline support for devicetree overlays. They are still
> absolutely critical and highly useful, solving problems that cannot be
> solved through boot-time devicetrees. I'm simply looking for an
> approach that will complement the availability of overlays and provide
> the best user experience.
>
> Robert has been talking about the actions required to clean-up Debian
> Jessie support in another thread
> (https://groups.google.com/d/msg/beagleboard/2b8rArtfABY/A8d1JzmJa4IJ)
> and I suggested we should add a bit of a detour by cleaning up the
> cape support for the mainline kernel and switching away our primary
> process of supporting capes from using overlays to using a single
> devicetree file provided at boot. I promised a pull-request and hadn't
> gotten around to sending it until now (below). No architecture changes
> have been made in my pull-request, just bringing in the kernel
> devicetree source history. This suggestion is based on several
> assumptions, any number of which might be wrong.
>
> The assumptions (for which I'm looking for feedback/corrections):
> * The overlays pretty much all need to be compiled into the kernel if
> they are going to be loaded using kernel command-line arguments or
> /etc/capemgr for the majority of distros. While many cape devicetree
> use cases are perfectly happy with loading at run-time rather than
> boot-time, it seems there should be a mechanism for pushing cape
> support into the category of being available at boot-time across
> distributions.
> * The devicetree sources, including the primary boot .dts files, will
> eventually be removed from the kernel source tree. I'm not too sure if
> and when it'll really happen, but starting up a project to maintain
> the definitive beagleboard.org board devicetree files outside the
> kernel seems to make sense. Given the interdependency of the boot .dtb
> and the overlay .dtbo files, combining them into a single repository
> where every distribution can pick them up seems like a natural and
> obvious choice. There are of course some dependencies on kernel
> versions, but I believe most of those have settled out by now and we
> should be OK moving forward.
> * There seems to be little or no interest in my previous proposal to
> use cape EEPROMs to store the overlay fragments. Given some churn in
> the devicetree node definitions, it is likely this would have failed
> in bad ways anyway. It seems mostly reasonable to expect users to
> update their kernel and firmware to gain support for new add-on
> hardware and we mostly try to avoid regressions (with the seemingly
> ever-living exception of 3D graphics support), so I think I'm better
> aligned with the community to drop my older suggestion. Some people,
> including CircuitCo, are building capes without configuration EEPROMs
> now, so a different recommended mechanism seems like a requirement.
> * With the patches in our vendor 3.8 kernels and with all recent
> mainline kernels, performing userspace muxing operations has become
> easy again. It seems to be possible to turn on drivers not currently
> in use without an unacceptable level of bloat or conflict. This has
> been partially proven out using Charles' universal cape
> (https://github.com/cdsteinkuehler/beaglebone-universal-io), though I
> still have some concerns about conflicts. The result might be that
> there is still some number of overlays, but the approach of minimizing
> the overlays and instead relying on the existing loading/unloading
> mechanisms of the mainline drivers as much as possible feels right to
> me.
> * It will still be some time before devicetree overlay support is
> adopted in the mainline kernel. While I still see a strong need to
> have devicetree overlay support and CapeMgr in the mainline, the
> desire here is to optimize the user experience in the shortest term
> possible. Users get really confused by the errors that get generated
> by loading incorrect devicetree overlays and it is always nice when
> you can avoid confusing users.
>
> My suggestion is:
> * Maintain the source for .dtb and .dtbo files for all BeagleBoard.org
> boards at http://github.com/beagleboard/devicetree-source, overriding
> the sources in the mainline kernel when performing kernel builds. We
> can host pre-built .dtb and .dtbo files at a normailzed location
> outside the source repository for those that don't want to perform the
> builds, since I don't believe the binary format is changing any time
> soon other than the overlay support we utilize. Any patches accepted
> into mainline as long as these files still exist there as well should
> be merged to try to keep these in-line as long as possible,
> anticipating eventual removal from mainline.
> * Have cape makers submit pull requests to have their cape enabled in
> the single boot-time devicetree overlay for each board they support.
> The base drivers should be enabled at the earliest point where they
> don't cause a conflict, minimizing what gets put into their overlays.
> The final mux configuration and other points of conflict should be
> kept in a board-specific overlay to make that configuration available
> at boot. If the cape is disabled on the kernel command-line, the
> kernel doesn't include CapeMgr support, or the board doesn't include a
> configuration EEPROM, users would still have the ability to perform
> run-time userspace mux configuration without CapeMgr unless
> conflicting drivers need to be loaded.
>
> Alternatively, if we don't think this is where things belong, perhaps
> we could try to move all of this into the u-boot sources, though
> people using other bootloaders might not find this the most useful
> approach.
>
> The pull request for http://github.com/beagleboard/devicetree-source:
>
> The following changes since commit
> a524bf5d5e173795ce4cb214280f304588b1d78d:
>
>   capes: add BB-VIEW-LCD4-01-00A0 & BB-VIEW-LCD7-01-00A0 (2014-05-29
> 15:59:31 -0500)
>
> are available in the git repository at:
>
>   git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:jadonk/cape-firmware master
>
> for you to fetch changes up to 9de20db80056b72d6e1f61b68447ba8f2d12cf9c:
>
>   Beagle DTS: remove deleted files from Makefile (2014-06-02 12:35:28
> -0400)
>
> ----------------------------------------------------------------
>
> [...] Too many changes to list bringing in kernel history.
>

-- 
For more options, visit http://beagleboard.org/discuss
--- 
You received this message because you are subscribed to the Google Groups "BeagleBoard" group.
To unsubscribe from this group and stop receiving emails from it, send an email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--e89a8ff2545011d9dc04fb8877ad
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Adding devicetree and linux-arm-kernel lists based on feed=
back on IRC...<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote"=
>On Tue, Jun 10, 2014 at 12:46 PM, Jason Kridner <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&=
gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I&#39;d like to discuss moving our current l=
ibrary of cape devicetree<br>
overlay sources into a single tree, including the boot .dtb files for<br>
BeagleBoard.org boards and moving towards enabling as much of the cape<br>
support into a single boot-time .dtb file with an approach similar to<br>
the cape-universal overlay<br>
(<a href=3D"https://github.com/cdsteinkuehler/beaglebone-universal-io" targ=
et=3D"_blank">https://github.com/cdsteinkuehler/beaglebone-universal-io</a>=
), but not<br>
in an overlay.<br>
<br>
First of all, I want to note this doesn&#39;t change my view on the<br>
importance of mainline support for devicetree overlays. They are still<br>
absolutely critical and highly useful, solving problems that cannot be<br>
solved through boot-time devicetrees. I&#39;m simply looking for an<br>
approach that will complement the availability of overlays and provide<br>
the best user experience.<br>
<br>
Robert has been talking about the actions required to clean-up Debian<br>
Jessie support in another thread<br>
(<a href=3D"https://groups.google.com/d/msg/beagleboard/2b8rArtfABY/A8d1Jzm=
Ja4IJ" target=3D"_blank">https://groups.google.com/d/msg/beagleboard/2b8rAr=
tfABY/A8d1JzmJa4IJ</a>)<br>
and I suggested we should add a bit of a detour by cleaning up the<br>
cape support for the mainline kernel and switching away our primary<br>
process of supporting capes from using overlays to using a single<br>
devicetree file provided at boot. I promised a pull-request and hadn&#39;t<=
br>
gotten around to sending it until now (below). No architecture changes<br>
have been made in my pull-request, just bringing in the kernel<br>
devicetree source history. This suggestion is based on several<br>
assumptions, any number of which might be wrong.<br>
<br>
The assumptions (for which I&#39;m looking for feedback/corrections):<br>
* The overlays pretty much all need to be compiled into the kernel if<br>
they are going to be loaded using kernel command-line arguments or<br>
/etc/capemgr for the majority of distros. While many cape devicetree<br>
use cases are perfectly happy with loading at run-time rather than<br>
boot-time, it seems there should be a mechanism for pushing cape<br>
support into the category of being available at boot-time across<br>
distributions.<br>
* The devicetree sources, including the primary boot .dts files, will<br>
eventually be removed from the kernel source tree. I&#39;m not too sure if<=
br>
and when it&#39;ll really happen, but starting up a project to maintain<br>
the definitive <a href=3D"http://beagleboard.org" target=3D"_blank">beagleb=
oard.org</a> board devicetree files outside the<br>
kernel seems to make sense. Given the interdependency of the boot .dtb<br>
and the overlay .dtbo files, combining them into a single repository<br>
where every distribution can pick them up seems like a natural and<br>
obvious choice. There are of course some dependencies on kernel<br>
versions, but I believe most of those have settled out by now and we<br>
should be OK moving forward.<br>
* There seems to be little or no interest in my previous proposal to<br>
use cape EEPROMs to store the overlay fragments. Given some churn in<br>
the devicetree node definitions, it is likely this would have failed<br>
in bad ways anyway. It seems mostly reasonable to expect users to<br>
update their kernel and firmware to gain support for new add-on<br>
hardware and we mostly try to avoid regressions (with the seemingly<br>
ever-living exception of 3D graphics support), so I think I&#39;m better<br=
>
aligned with the community to drop my older suggestion. Some people,<br>
including CircuitCo, are building capes without configuration EEPROMs<br>
now, so a different recommended mechanism seems like a requirement.<br>
* With the patches in our vendor 3.8 kernels and with all recent<br>
mainline kernels, performing userspace muxing operations has become<br>
easy again. It seems to be possible to turn on drivers not currently<br>
in use without an unacceptable level of bloat or conflict. This has<br>
been partially proven out using Charles&#39; universal cape<br>
(<a href=3D"https://github.com/cdsteinkuehler/beaglebone-universal-io" targ=
et=3D"_blank">https://github.com/cdsteinkuehler/beaglebone-universal-io</a>=
), though I<br>
still have some concerns about conflicts. The result might be that<br>
there is still some number of overlays, but the approach of minimizing<br>
the overlays and instead relying on the existing loading/unloading<br>
mechanisms of the mainline drivers as much as possible feels right to<br>
me.<br>
* It will still be some time before devicetree overlay support is<br>
adopted in the mainline kernel. While I still see a strong need to<br>
have devicetree overlay support and CapeMgr in the mainline, the<br>
desire here is to optimize the user experience in the shortest term<br>
possible. Users get really confused by the errors that get generated<br>
by loading incorrect devicetree overlays and it is always nice when<br>
you can avoid confusing users.<br>
<br>
My suggestion is:<br>
* Maintain the source for .dtb and .dtbo files for all BeagleBoard.org<br>
boards at <a href=3D"http://github.com/beagleboard/devicetree-source" targe=
t=3D"_blank">http://github.com/beagleboard/devicetree-source</a>, overridin=
g<br>
the sources in the mainline kernel when performing kernel builds. We<br>
can host pre-built .dtb and .dtbo files at a normailzed location<br>
outside the source repository for those that don&#39;t want to perform the<=
br>
builds, since I don&#39;t believe the binary format is changing any time<br=
>
soon other than the overlay support we utilize. Any patches accepted<br>
into mainline as long as these files still exist there as well should<br>
be merged to try to keep these in-line as long as possible,<br>
anticipating eventual removal from mainline.<br>
* Have cape makers submit pull requests to have their cape enabled in<br>
the single boot-time devicetree overlay for each board they support.<br>
The base drivers should be enabled at the earliest point where they<br>
don&#39;t cause a conflict, minimizing what gets put into their overlays.<b=
r>
The final mux configuration and other points of conflict should be<br>
kept in a board-specific overlay to make that configuration available<br>
at boot. If the cape is disabled on the kernel command-line, the<br>
kernel doesn&#39;t include CapeMgr support, or the board doesn&#39;t includ=
e a<br>
configuration EEPROM, users would still have the ability to perform<br>
run-time userspace mux configuration without CapeMgr unless<br>
conflicting drivers need to be loaded.<br>
<br>
Alternatively, if we don&#39;t think this is where things belong, perhaps<b=
r>
we could try to move all of this into the u-boot sources, though<br>
people using other bootloaders might not find this the most useful<br>
approach.<br>
<br>
The pull request for <a href=3D"http://github.com/beagleboard/devicetree-so=
urce" target=3D"_blank">http://github.com/beagleboard/devicetree-source</a>=
:<br>
<br>
The following changes since commit a524bf5d5e173795ce4cb214280f304588b1d78d=
:<br>
<br>
=C2=A0 capes: add BB-VIEW-LCD4-01-00A0 &amp; BB-VIEW-LCD7-01-00A0 (2014-05-=
29<br>
15:59:31 -0500)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:jadonk/cape-firmware master<br>
<br>
for you to fetch changes up to 9de20db80056b72d6e1f61b68447ba8f2d12cf9c:<br=
>
<br>
=C2=A0 Beagle DTS: remove deleted files from Makefile (2014-06-02 12:35:28 =
-0400)<br>
<br>
----------------------------------------------------------------<br>
<br>
[...] Too many changes to list bringing in kernel history.<br>
</blockquote></div><br></div></div>

<p></p>

-- <br />
For more options, visit <a href=3D"http://beagleboard.org/discuss">http://b=
eagleboard.org/discuss</a><br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;BeagleBoard&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">beagleb=
oard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--e89a8ff2545011d9dc04fb8877ad--
