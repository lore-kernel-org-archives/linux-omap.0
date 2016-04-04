From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Mon, 04 Apr 2016 07:45:24 +0300
Message-ID: <87zita6kyj.fsf@intel.com>
References: <Pine.LNX.4.44L0.1603311255560.1516-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1603311255560.1516-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> writes:
> On Thu, 31 Mar 2016, Ivaylo Dimitrov wrote:
>
>> > This isn't supposed to cause any problems.  The two instances should
>> > never run at the same time, because they belong to different configs.
>> >
>>=20
>> The problem seems to be that fsg driver creates a thread for every=20
>> fsg_bind() call, which overwrites common->thread_task without first=20
>> checking if a thread is already created. I don't know the idea behind -=
=20
>> should it have only one thread for all instances, or there should be a=20
>> thread per instance, but anyway the current implementation looks wrong.
>
> You've put your finger on the problem.
>
> Michal, I'm not sure how you intended to handle this.  We only need to
> have one thread per interface (even if there's more than one LUN), but
> if there are multiple mass-storage interfaces in one configuration then
> you might want to have multiple threads.  Of course, then you would
> have to handle cases where one config has one mass-storage interface
> and another config has two...
>
> It's your decision, but clearly the driver needs to be fixed.

I agree, this is now very clear what the problem is.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAfFlAAoJEIaOsuA1yqREbGIP/2oH+lUruOxj0V1+Wv0LzZwz
3EgyuYgt0BdtEIMj7NzysybGbo1cnw9PaQfZ2L/tLlaT7sqk9plfwbIoAPDS31xm
k+HtrG+gIyIHFOXMU1MDd7OE/h9d4xf4AvLqagrkNzXoJVEqmMdu2s7K/YQftVem
IZbNX8+vtAahMeKdXnD+MbX6qg/e6H2QFjHNc8rvjpL5PlAtJC1J1ZgtApvdG82m
/4A6fM4jyUwPlIQAcTyanlHSNYbCCjwrgDyTkWcPB65tZmWHsuj721ZdrbhZ0VXJ
NQZJlk6FK0CIxLuGdJPxwhdD32nfPosBy0rJeTqoikdju/Q9YMfSSkgsld+37Wgj
5W7pW2LCVlxcbgSmY14C21XmrVn/m6zIPvR7uSjhKIEral9BKfcgXCYmrpuQfH15
BYtOM3lKnMJlARLeR3a03NmMHjftHjYh9WuBinjtcXwCWdHNFmEQEvtNMuKgyB6t
NwQZdKH0Ducp8fE6UK05EsxYPqSHk5sdwfquXgEIE0ADYZFGsOPwpWfZmKhWhCuD
YzprEYZ2PYf+TA0uwFrVv8Jqu7Fe1e/JOV4uzjkdBHH+8ZBhlU7R08fUdw8FfSPs
fpKO7mFe2xHw6AcP9lOLOF1sm4N8p0hH0+/QtDMBpZByYI0F3TaN2t0ZP1GnvF2F
qYFeN1tYq2dRTAr68zMB
=Hwll
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
