From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 10:39:02 +0200
Message-ID: <AANLkTil-BYnf3swXPj_Llm-XpTks9-NKEi8fgq07JFV3@mail.gmail.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
	<20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
	<AANLkTilYHKKmQePBGW3LVLjUZy7HXHQku2Iub-LWGBm6@mail.gmail.com>
	<20100528132138.2d802d77@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100528132138.2d802d77@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Mailing List <linux-omap@vger.kernel.org>, Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Peter@smtp1.linux-foundation.org, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

2010/5/28 Alan Cox <alan@lxorguk.ukuu.org.uk>:
> Ok lets try and produce something more concrete. The control groups m=
ay
> be the wrong tool but we've got several such tools already
>
>
> Kernel involved
> ----------------
> acquire: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mark myself important (into c=
group important)
> acquire(timeout) =A0 =A0 =A0 =A0ditto, plus app timer/timeout handler
> release: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mark myself unimportant (into=
 cgroup downtrodden)

May we somehow live without acquire(timeout)? This is the feature that
can screw up a lot of things with very complicated debugging options.

~Vitaly
