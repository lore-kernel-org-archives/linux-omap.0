From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: OMAP310 i2c fix
Date: Thu, 21 Dec 2006 15:30:44 -0800
Message-ID: <20061221233043.GM10399@atomide.com>
References: <200611121930.36087.marek.vasut@gmail.com>
	<200611121935.18179.marek.vasut@gmail.com>
	<5d5443650611130132i40800c09pc8f2801ee4f56625@mail.gmail.com>
	<200611131705.46392.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200611131705.46392.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061113 09:16]:
> Dne pond=C4=9Bl=C3=AD 13 listopad 2006 10:32 jste napsal(a):
> > On 11/12/06, Marek Va=C5=A1ut <marek.vasut@gmail.com> wrote:
> > > Dne ned=C4=9Ble 12 listopad 2006 19:30 jste napsal(a):
> > > > Hi,
> > > >
> > > > when I turned on i2c on my omap310 based palmz71 and booted the k=
ernel,
> > > > it hanged. I=C2=B4ve tracked the place where it hangs and fixed i=
t. Here=C2=B4s
> > > > the small patch.
> > >
> > > forgot to add this ;-)
> > >
> > > Signed-off-by: Marek Va=C5=A1ut <marek.vasut@gmail.com>
> >
> > Just to confirm your patch comment. Did you enabled OMAP_DSP or I2C?
> > as you had modified dsp_common.c. Going the generic way, dsp_common.c
> > should pick up memory addresses from arch- specific files, but as
> > omap_dsp_init is called in arch_init, I don't know, what would be the
> > cleaner way to do it.
>=20
> yes, I enabled i2c.

Pushing this today.

Tony
