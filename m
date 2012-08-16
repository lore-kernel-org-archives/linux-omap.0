From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 0/8] ARM: OMAP2+: PM: introduce the power domains
 functional states
Date: Wed, 15 Aug 2012 18:48:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208151842380.8833@utopia.booyaka.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com> <CAMQu2gxznhsbK3--nyQmYdHqyGjwpCSa3CJx8aYpF4wwR1qBSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-19803156-1345078093=:8833"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45848 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab2HPAsO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 20:48:14 -0400
In-Reply-To: <CAMQu2gxznhsbK3--nyQmYdHqyGjwpCSa3CJx8aYpF4wwR1qBSg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-19803156-1345078093=:8833
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Santosh,

On Wed, 15 Aug 2012, Shilimkar, Santosh wrote:

> On Wed, Aug 15, 2012 at 3:32 PM, Jean Pihet <jean.pihet@newoldbits.com> w=
rote:
>
> I didn't find any mention here about why are we going in this path and no=
t
> in the direction proposed in another RFC [1]
> I have already given my comments[2] against the introduction of another P=
D
> layer which can be avoided easily as demonstrated by the RFC[1]. The comm=
ents
> are still applicable for this series too.
>=20
> We really need to reduce OMAP specific framework overhead and
> move towards more generic PM frameworks. For me, this series is
> a step back-ward from that direction. Am really sorry for being critical
> again but I remain unconvinced about this series and the problem it
> is trying to solve.
>=20
> May be you have valid reasons not to follow the approach in [1] and in
> that case, it will be good to clarify that so that some of us get
> to know your rationale.

I've asked Jean to handle the work of evaluating and/or integrating any=20
feedback from you and Rajendra into this series.  Jean, has this latest=20
series fully considered those issues?  Or are there still some areas of=20
misalignment / lack of clarity?

Anyway.  If there's a problem with this process, it sounds like you,=20
Rajendra, Jean, Beno=EEt and I should schedule some time to talk over the=
=20
same issues that you discussed with me on the phone.  Perhaps next week?


- Paul
--155748971-19803156-1345078093=:8833--
