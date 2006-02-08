From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: serial on omap in current git.
Date: Tue, 7 Feb 2006 18:18:39 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A504365D24@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C62C45.36B97835"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C62C45.36B97835
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Here is one it should get the FCR set correctly.  There is still
something wrong though.

Regards,
Richard W.


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, February 07, 2006 6:14 PM
> To: Woodruff, Richard
> Cc: Linux-omap-open-source@linux.omap.com
> Subject: Re: serial on omap in current git.
>=20
> * Woodruff, Richard <r-woodruff2@ti.com> [060207 16:00]:
> > Tony,
> >
> > Not that it fixes the issue you saw but it may half explain others.
With
> > the tx threshold interrupt.
> >
> > 	The:
> > 		serial_outp(up, UART_FCR, fcr) in
> > serial8250_set_termios() won't set the UART_FCR_T_TRIG_10 as
expected as
> > the UART_EFR.UART_EFR_ECB bit is not set.  Bits 5:4 of the FCR are
not
> > settable with out the EFR bit4 set.
> >
> > The current code seems to only think it needs to set the ECB at
sleep
> > time, else it just writes a 0 back into the EFR.
>=20
> Thanks. Do you have a patch around for that?
>=20
> Tony

------_=_NextPart_001_01C62C45.36B97835
Content-Type: application/octet-stream;
	name="serial.diff"
Content-Transfer-Encoding: base64
Content-Description: serial.diff
Content-Disposition: attachment;
	filename="serial.diff"

LS0tIGxpbnV4LW9tYXAtMi42LWRldi9kcml2ZXJzL3NlcmlhbC84MjUwLmMJMjAwNi0wMi0wNyAx
NToxMDoxMi4wMDAwMDAwMDAgLTA2MDAKKysrIGxpbnV4LW9tYXAtMi42L2RyaXZlcnMvc2VyaWFs
LzgyNTAuYwkyMDA2LTAyLTA3IDE3OjAzOjI4LjAwMDAwMDAwMCAtMDYwMApAQCAtMTg4Nyw2ICsx
ODg3LDEwIEBAIHNlcmlhbDgyNTBfc2V0X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAKIAlzZXJp
YWxfb3V0cCh1cCwgVUFSVF9MQ1IsIGN2YWwpOwkJLyogcmVzZXQgRExBQiAqLwogCXVwLT5sY3Ig
PSBjdmFsOwkJCQkJLyogU2F2ZSBMQ1IgKi8KIAlpZiAodXAtPnBvcnQudHlwZSAhPSBQT1JUXzE2
NzUwKSB7CisJCWlmKHVhcnRfY29uZmlnW3VwLT5wb3J0LnR5cGVdLmZsYWdzICYgVUFSVF9DQVBf
RUZSKXsKKwkJCXNlcmlhbF9vdXRwKHVwLCBVQVJUX0VGUiwgVUFSVF9FRlJfRUNCKTsKKwkJCXBy
aW50aygiXG5NQUtFIFNVUkUgVFggVEhSRVNIT0xEIEdFVFMgU0VUIGluIEZDUiB3cml0ZSBcbiIp
OworCQl9CiAJCWlmIChmY3IgJiBVQVJUX0ZDUl9FTkFCTEVfRklGTykgewogCQkJLyogZW11bGF0
ZWQgVUFSVHMgKEx1Y2VudCBWZW51cyAxNjd4KSBuZWVkIHR3byBzdGVwcyAqLwogCQkJc2VyaWFs
X291dHAodXAsIFVBUlRfRkNSLCBVQVJUX0ZDUl9FTkFCTEVfRklGTyk7Cg==

------_=_NextPart_001_01C62C45.36B97835
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C62C45.36B97835--
