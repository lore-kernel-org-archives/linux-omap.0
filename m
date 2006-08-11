From: Tony Lindgren <tony@atomide.com>
Subject: Re: Suspending with keypad bug (RFC)
Date: Fri, 11 Aug 2006 13:04:04 +0300
Message-ID: <20060811100403.GF6720@atomide.com>
References: <fb249edb0608041633y58eef1b8we6f00cccf69c99a0@mail.gmail.com>
	<44D6423F.3070001@solidboot.com>
	<fb249edb0608092155r20c17f5dl6397c3d9d191105b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0608092155r20c17f5dl6397c3d9d191105b@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060810 07:56]:
> On 06/08/06, Juha Yrj=F6l=E4 <juha.yrjola@solidboot.com> wrote:
> >andrzej zaborowski wrote:
> >
> >> I came up with a different fix, in the keypad driver but it's a bit
> >> more intrusive. With this the device sleeps peacefully until another
> >> key-press is detected. What should be the correct behavior?
> >> I'm attaching both changes.
> >
> >This approach is better; the generic PM code should not have to care
> >that much about different wakeup sources.
> >
> >I'm not exactly sure in which state the system is when the suspend
> >function is called.  Can there still be timer activity, for example?
>=20
> I think yes, some suspend functions may rely on timers because they
> are not obliged to return immdiately.
>=20
> >Nevertheless, you're safer doing a spin_lock_irqsave() in the suspend
> >function first, and releasing the lock only after setting the suspende=
d
> >variable and re-enabling the interrupt.
> >
> >You should also check whether you're actually running on OMAP1 before
> >you write to the register.
> >
> >In the IRQ handler, you should also do a spin_lock_irqsave() before
> >accessing the suspended variable.
>=20
> Thanks for help! I'm attaching the corrected version, it works nicely.
>=20
> In the irq handler I release the lock just after accessing the
> "suspended" variable because as I understand an irq handler will never
> be interrupted by something that calls the suspend function.

Can you please repost with proper comments and Signed-off-by?

Thanks,

Tony
