From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Fwd: [PATCH RFC] arch/arm/plat-omap/devices.c
Date: Mon, 1 Oct 2007 21:10:57 -0300
Message-ID: <ae36f8040710011710h84739cfrd20e19981775481b@mail.gmail.com>
References: <ae36f8040709181333q2b8e3e6ena5d864b14178c582@mail.gmail.com>
	<46F1450E.8020307@googlemail.com> <20071001180626.GN24656@atomide.com>
	<ae36f8040710011620s33ae47c1hdb9b985423074b81@mail.gmail.com>
	<20071002000102.GR24656@atomide.com>
	<ae36f8040710011707u34b21a1dx1e63db8c7bd85c9d@mail.gmail.com>
	<ae36f8040710011710w50e766c3ve10cded27a6e0689@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7081_21136243.1191283857315"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <ae36f8040710011710w50e766c3ve10cded27a6e0689@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_7081_21136243.1191283857315
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

---------- Forwarded message ----------
From: Lu=EDs Cargnini <lvcargnini@gmail.com>
Date: Oct 1, 2007 9:10 PM
Subject: Re: [PATCH RFC] arch/arm/plat-omap/devices.c
To: Tony Lindgren <tony@atomide.com>



On 10/1/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
>
> the mcbsp.c doesn't ?
> ok I'll remake the patch and resubmitting right now.
>
> On 10/1/07, Tony Lindgren < tony@atomide.com > wrote:
> >
> > * Lu=EDs Cargnini < lvcargnini@gmail.com > [071001 16:20]:
> > > Tony please I submitted a patch for mcbsp.{c,h}, modifying it to
> > support
> > > shared IRQ on McBSP ports, it are working for me, and for my device
> > driver,
> > > I'm testing it yet it take me sometime. But the device diver isn't a
> > major
> > > question, only the interruption modification on mcbsp file as I said.
> >
> > Yeah at least the header patch looks OK.
> >
> > Regards,
> >
> > Tony
> >
>
>
>
> --
> -------------------------------------------------------------------------=
-----
>
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Electrical Engineer Faculty @ PUCRS
> Ipiranga Avenue, 6681 =96 Building 30
> P.O. Box: 90619-900 =96 Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
> -------------------------------------------------------------------------=
--------
>
>



--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------




--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------

------=_Part_7081_21136243.1191283857315
Content-Type: application/octet-stream; name="mcbsp.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mcbsp.c.patch";
	filename="mcbsp.c.patch"
X-Attachment-Id: f_f79nmmlz

LS0tIGxpbnV4LW9tYXAtMi42L2FyY2gvYXJtL3BsYXQtb21hcC9tY2JzcC5jCTIwMDctMDMtMTIg
MTY6NDQ6MDMuNTAxODkwODQ0IC0wMzAwCisrKyBsaW51eC1vbWFwLTIuNi1pbnN0cmFtZWQvYXJj
aC9hcm0vcGxhdC1vbWFwL21jYnNwLmMJMjAwNy0wOS0yNiAwMDoyNDozMy45MjgzMDczMzAgLTAz
MDAKQEAgLTIwLDggKzIwLDggQEAKICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KICNpbmNs
dWRlIDxsaW51eC9lcnIuaD4KICNpbmNsdWRlIDxsaW51eC9jbGsuaD4KLSNpbmNsdWRlIDxsaW51
eC9kZWxheS5oPgogCisjaW5jbHVkZSA8YXNtL2RlbGF5Lmg+CiAjaW5jbHVkZSA8YXNtL2lvLmg+
CiAjaW5jbHVkZSA8YXNtL2lycS5oPgogCkBAIC05NCw2ICs5NCwyMiBAQCBzdGF0aWMgdm9pZCBv
bWFwX21jYnNwX2R1bXBfcmVnKHU4IGlkKQogCURCRygiU1JHUjE6IDB4JTA0eFxuIiwgT01BUF9N
Q0JTUF9SRUFEKG1jYnNwW2lkXS5pb19iYXNlLCBTUkdSMSkpOwogCURCRygiUENSMDogIDB4JTA0
eFxuIiwgT01BUF9NQ0JTUF9SRUFEKG1jYnNwW2lkXS5pb19iYXNlLCBQQ1IwKSk7CiAJREJHKCIq
KioqKioqKioqKioqKioqKioqKioqKlxuIik7CisJLyogVml0b3JpbyAxOS8wOS8yMDA3IC0gMTA6
NDggfCAtMDM6MDBHTVQgKi8KKwlwcmludGsoS0VSTl9JTkZPICIqKioqIE1DQlNQJWQgcmVncyAq
KioqXG4iLCBtY2JzcFtpZF0uaWQpOworCXByaW50ayhLRVJOX0lORk8gIkRSUjI6ICAweCUwNHhc
biIsIE9NQVBfTUNCU1BfUkVBRChtY2JzcFtpZF0uaW9fYmFzZSwgRFJSMikpOworCXByaW50ayhL
RVJOX0lORk8gIkRSUjE6ICAweCUwNHhcbiIsIE9NQVBfTUNCU1BfUkVBRChtY2JzcFtpZF0uaW9f
YmFzZSwgRFJSMSkpOworCXByaW50ayhLRVJOX0lORk8gIkRYUjI6ICAweCUwNHhcbiIsIE9NQVBf
TUNCU1BfUkVBRChtY2JzcFtpZF0uaW9fYmFzZSwgRFhSMikpOworCXByaW50ayhLRVJOX0lORk8g
IkRYUjE6ICAweCUwNHhcbiIsIE9NQVBfTUNCU1BfUkVBRChtY2JzcFtpZF0uaW9fYmFzZSwgRFhS
MSkpOworCXByaW50ayhLRVJOX0lORk8gIlNQQ1IyOiAweCUwNHhcbiIsIE9NQVBfTUNCU1BfUkVB
RChtY2JzcFtpZF0uaW9fYmFzZSwgU1BDUjIpKTsKKwlwcmludGsoS0VSTl9JTkZPICJTUENSMTog
MHglMDR4XG4iLCBPTUFQX01DQlNQX1JFQUQobWNic3BbaWRdLmlvX2Jhc2UsIFNQQ1IxKSk7CisJ
cHJpbnRrKEtFUk5fSU5GTyAiUkNSMjogIDB4JTA0eFxuIiwgT01BUF9NQ0JTUF9SRUFEKG1jYnNw
W2lkXS5pb19iYXNlLCBSQ1IyKSk7CisJcHJpbnRrKEtFUk5fSU5GTyAiUkNSMTogIDB4JTA0eFxu
IiwgT01BUF9NQ0JTUF9SRUFEKG1jYnNwW2lkXS5pb19iYXNlLCBSQ1IxKSk7CisJcHJpbnRrKEtF
Uk5fSU5GTyAiWENSMjogIDB4JTA0eFxuIiwgT01BUF9NQ0JTUF9SRUFEKG1jYnNwW2lkXS5pb19i
YXNlLCBYQ1IyKSk7CisJcHJpbnRrKEtFUk5fSU5GTyAiWENSMTogIDB4JTA0eFxuIiwgT01BUF9N
Q0JTUF9SRUFEKG1jYnNwW2lkXS5pb19iYXNlLCBYQ1IxKSk7CisJcHJpbnRrKEtFUk5fSU5GTyAi
U1JHUjI6IDB4JTA0eFxuIiwgT01BUF9NQ0JTUF9SRUFEKG1jYnNwW2lkXS5pb19iYXNlLCBTUkdS
MikpOworCXByaW50ayhLRVJOX0lORk8gIlNSR1IxOiAweCUwNHhcbiIsIE9NQVBfTUNCU1BfUkVB
RChtY2JzcFtpZF0uaW9fYmFzZSwgU1JHUjEpKTsKKwlwcmludGsoS0VSTl9JTkZPICJQQ1IwOiAg
MHglMDR4XG4iLCBPTUFQX01DQlNQX1JFQUQobWNic3BbaWRdLmlvX2Jhc2UsIFBDUjApKTsKKwlw
cmludGsoS0VSTl9JTkZPICIqKioqKioqKioqKioqKioqKioqKioqKlxuIik7CiB9CiAKIHN0YXRp
YyBpcnFyZXR1cm5fdCBvbWFwX21jYnNwX3R4X2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRl
dl9pZCkKQEAgLTMwNCw3ICszMjAsNyBAQCBpbnQgb21hcF9tY2JzcF9yZXF1ZXN0KHVuc2lnbmVk
IGludCBpZCkKIAogCWlmIChtY2JzcFtpZF0uaW9fdHlwZSA9PSBPTUFQX01DQlNQX0lSUV9JTykg
ewogCQkvKiBXZSBuZWVkIHRvIGdldCBJUlFzIGhlcmUgKi8KLQkJZXJyID0gcmVxdWVzdF9pcnEo
bWNic3BbaWRdLnR4X2lycSwgb21hcF9tY2JzcF90eF9pcnFfaGFuZGxlciwgMCwKKwkJZXJyID0g
cmVxdWVzdF9pcnEobWNic3BbaWRdLnR4X2lycSwgb21hcF9tY2JzcF90eF9pcnFfaGFuZGxlciwg
SVJRRl9TSEFSRUQsCiAJCQkJICAiTWNCU1AiLAogCQkJCSAgKHZvaWQgKikgKCZtY2JzcFtpZF0p
KTsKIAkJaWYgKGVyciAhPSAwKSB7CkBAIC0zMTUsOCArMzMxLDcgQEAgaW50IG9tYXBfbWNic3Bf
cmVxdWVzdCh1bnNpZ25lZCBpbnQgaWQpCiAKIAkJaW5pdF9jb21wbGV0aW9uKCYobWNic3BbaWRd
LnR4X2lycV9jb21wbGV0aW9uKSk7CiAKLQotCQllcnIgPSByZXF1ZXN0X2lycShtY2JzcFtpZF0u
cnhfaXJxLCBvbWFwX21jYnNwX3J4X2lycV9oYW5kbGVyLCAwLAorCSAgCWVyciA9IHJlcXVlc3Rf
aXJxKG1jYnNwW2lkXS5yeF9pcnEsIG9tYXBfbWNic3BfcnhfaXJxX2hhbmRsZXIsIElSUUZfU0hB
UkVELAogCQkJCSAgIk1jQlNQIiwKIAkJCQkgICh2b2lkICopICgmbWNic3BbaWRdKSk7CiAJCWlm
IChlcnIgIT0gMCkgewo=
------=_Part_7081_21136243.1191283857315
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_7081_21136243.1191283857315--
