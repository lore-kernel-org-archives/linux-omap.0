From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/4] MFD: twl4030: add twl4030_codec MFD as a new child
 to the core
Date: Thu, 22 Oct 2009 09:57:49 +0200
Message-ID: <20091022075748.GA8105@sortiz.org>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
 <1255956140-4829-2-git-send-email-peter.ujfalusi@nokia.com>
 <20091021231311.GF17796@sortiz.org>
 <200910220904.32676.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752997AbZJVILO@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200910220904.32676.peter.ujfalusi@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 22, 2009 at 09:04:32AM +0300, Peter Ujfalusi wrote:
> I'll check, if the MFD patch applies to mfd-2.6:for-next also, but to=
 have the=20
> soc codec changes the MFD patch should go to the sound-2.6 tree as we=
ll to make=20
> sure it is not braking things.
>=20
> All-in-all, how these things can be handled?
The OMAP patch has been acked by Tony. Then we I'm fine with the mfd on=
e and
Mark is also ok with the remaining asoc one, all 3 patches have to go t=
hrough
one single tree.

It seems to me that this patchset is mostly an asoc one, even though al=
l of
those patches depend on the MFD one. So I'd perfectly fine if they'd al=
l go
through Mark's tree, and then I'd have to make sure I'm sending my 2.6.=
33
merge window pull request _after_ Mark's code is in Linus tree. Once it=
's
there, I can work on merging conflicts with the few twl4030-core pendin=
g
patches from my tree. Mark, what do you think ?

Cheers,
Samuel.

=20
> Thanks,=20
> P=E9ter

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
