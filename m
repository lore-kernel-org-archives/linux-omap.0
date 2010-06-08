From: Valdis.Kletnieks@vt.edu
Subject: Re: suspend blockers & Android integration
Date: Mon, 07 Jun 2010 22:15:00 -0400
Message-ID: <9277.1275963300@localhost>
References: <1275834706.7227.545.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
	<1275844114.7227.552.camel@mulgrave.site>
	<20100606190525.GA20517@infradead.org>
	<AANLkTikKx-gXCGtNo3woHLCpBoEQ7hG9Jbiq3hwUTW_w@mail.gmail.com>
	<20100606192405.GA7559@infradead.org>
	<AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
	<1275916830.1645.566.camel@laptop>
	<AANLkTik-0JRJTEbVkr4LUsnELRuqpmGYrRsMxVZDpz8C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7958033586505686804=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Your message of "Tue, 08 Jun 2010 01:17:13 +0200."
	<AANLkTik-0JRJTEbVkr4LUsnELRuqpmGYrRsMxVZDpz8C@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, hackbod@android.com, Christoph Hellwig <hch@infradead.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============7958033586505686804==
Content-Type: multipart/signed; boundary="==_Exmh_1275963300_4518P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1275963300_4518P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jun 2010 01:17:13 +0200, Linus Walleij said:

> So I would really like to know from the Android people why the
> binder is in the kernel, after all. Could it *theoretically* be in
> userspace, on top of some unix domain sockets, running as a
> real-time scheduled daemon or whatever, still yielding the same
> performance? Or is there some discovered limitation with current
> interfaces, that everybody ought to know?

Not an Android person, but...

How expensive is a userspace->kernel transition on Android-class hardware=
?
There's certainly something to be said for short-circuiting the path
source_process -> kernel -> broker_process -> kernel -> dest_process
down to the shorter source->kernel->dest

--==_Exmh_1275963300_4518P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMDaekcC3lWbTT17ARAt6/AKDbDjjyziWGe4de18hkFdAqzkypvwCghfkj
Ynyp1vcd2/PGbvCNUFucXqo=
=gM5X
-----END PGP SIGNATURE-----

--==_Exmh_1275963300_4518P--


--===============7958033586505686804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7958033586505686804==--
