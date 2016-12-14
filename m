From: Sebastian Reichel <sre@kernel.org>
Subject: Re: partial bluetooth success on n900 [was Re: bluetooth/uart
 timeout handling]
Date: Wed, 14 Dec 2016 14:31:58 +0100
Message-ID: <20161214133158.mwvs574l4otbc7hf@earth>
References: <20161016002454.ul5rdqwubvkct4pf@earth>
 <20161018224259.jrwbaal27irzjqyo@earth> <20161019092506.GA1461@amd>
 <201612141321.30181@pali> <20161214125323.GA4951@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5895599743950194113=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161214125323.GA4951@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, abcloriens@gmail.com, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============5895599743950194113==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="heih7bufcowefweg"
Content-Disposition: inline


--heih7bufcowefweg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pali & Pavel,

On Wed, Dec 14, 2016 at 01:53:23PM +0100, Pavel Machek wrote:
> > > [  220.248596] tty ttyO1: Radio packet sent
> > > [  220.249328] Bluetooth: hci0: Frame reassembly failed (-84)
> > > [  220.272949] tty ttyO1: wakeup received: 1 -> 0
> > > [  221.283477] tty ttyO1: radio packet timeout!
> > > [  221.283630] enqueue: hu c304cc80 skb cd4a9b40
> > > [  223.363372] Bluetooth: hci0 command 0xfc18 tx timeout
> > > pavel@n900:~$
> >=20
> > In log are still some failures, but ... is bluetooth working now?

I could scan for devices. The code is still racy, though. It's
most likely related to the newly introduced idle code. (Without
sending the BT module to correctly idle the bcm2048 does not
work correctly at all)

I was quite busy the last few weeks and did not manage to find
much time for kernel work. Now I will first have to catch up
with my power-supply tree.

> It is... for Sebastian. I'm playing with camera now.
>=20
> > I see that you applied this patch:=20
> > https://git.kernel.org/cgit/linux/kernel/git/pavel/linux-n900.git/commi=
t/?id=3D051aa3fbf03ac770d8344690f5a936a7f04c6884
> >=20
> > Looks like that pinmux is in DTS file incorrect. Can somebody verify it=
?=20
> > Maybe Tony?
>=20
> Yes, it is. Sebastian was pretty certain about that.

Yes, I'm certain. The bootloader enables the pullup resistors.
Note, that the wrong DTS entry is not in mainline. My bluetooth
branch has a fixed DTS patch instead of a fixup patch on top of
the broken one:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-n900.git/commit/?h=
=3Dnokia-bluetooth-dev&id=3D6b63c111a979d100cfbdd76cb4a6bbadace35216

-- Sebastian

--heih7bufcowefweg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhRScAACgkQ2O7X88g7
+pqBGw/9Gng2PM9INPQbLbwOl6/FJsIVm2xQrVa7gLU0Kgzix/zhIBJtOt5Uyk+N
FVdIgn/KWGGca0ZwhoW5gyQg7Swy0lC8H9XKAamrbW04c5C1+k+xPnSGXWFvmJ4b
JG/7kAT4HxayYmYl4dGS7fSGgp63xG1h209EsQgdn4UbGJiOnP2Q5bViVil/FfiX
JtVEpAwKVlbIjDcGX+3DSFPLt5dpHJn4U8ww0jgxvr5QFceElSR0NxSs1oNtkEja
NrePTrIReWoJnmL420zsYiB6/U77+gDyl0YKHeKD9WBxz2gm4cIZE1JJdqzKB7PV
5HF5Vm09jIIwHX4MoKwOs8Wax8s6ulwEmywvdZOnPrpDSxu9An1L8IibrA5KCiEK
iO+A6bpBbrRV7+Y9wt+oEK5+hkSacAOQSUNE7rFMmG4U+y+ZbS+Immj0bCPUvXtW
MwmMEgQpMQJg+PFTwLKxL3s6CBICn9iNxznj98JnJOJzIlqgc7p0cOjk3GTuk0Z1
Cmux4uJjQunLjwT6s5lkbiywIAp40PN98dhnfsUnOPFZXr74ZfTX6vzyXSs5OWQR
Hpe1A29ACRhgqeEopiihHx84nlQSQ2CbNXvN2LZhFdSJCksnDx+L+38WEZofq77t
JzZ5D9C2ELooIwhAgKpY0nWcW1igfREDTKSNFYIplWw/GUt2p9w=
=dzi5
-----END PGP SIGNATURE-----

--heih7bufcowefweg--


--===============5895599743950194113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5895599743950194113==--
