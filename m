From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Tue, 2 Apr 2013 09:17:14 -0700
Message-ID: <20130402161713.GR10155@atomide.com>
References: <414980284.76676.1364848631348.JavaMail.apache@mail82.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <414980284.76676.1364848631348.JavaMail.apache@mail82.abv.bg>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>
Cc: pali.rohar@gmail.com, juha.yrjola@solidboot.com, linux@arm.linux.org.uk, mpm@selenic.com, herbert@gondor.apana.org.au, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=
=80=D0=BE=D0=B2 <freemangordon@abv.bg> [130401 13:41]:
>  It could be that I am misreading something, but RX51 is OMAP3.

Yes the FIQs are only accessible in the secure mode starting with
omap2. So that also means omap3, 4, 5.

Regards,

Tony
