From: <Tero.Kristo@nokia.com>
Subject: RE: getnstimeofday() and suspend
Date: Fri, 15 Aug 2008 13:43:01 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394305E57FA@vaebe110.NOE.Nokia.com>
References: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com> <20080813140016.GE27446@atomide.com> <B71CE868F2BC2847B3F23C5A8EE394305AB858@vaebe110.NOE.Nokia.com> <B71CE868F2BC2847B3F23C5A8EE394305E574F@vaebe110.NOE.Nokia.com> <1218792793.28834.33.camel@localhost> <878wuyob5q.fsf@trdhcp146196.ntc.nokia.com> <1218795052.28834.40.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C8FEC3.B0CE9EFA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39053 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbYHOKnj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 06:43:39 -0400
Content-class: urn:content-classes:message
In-reply-to: <1218795052.28834.40.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor.Stoppa@nokia.com, jouni.hogander@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8FEC3.B0CE9EFA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20

>-----Original Message-----
>From: Stoppa Igor (Nokia-D/Helsinki)=20
>Sent: 15 August, 2008 13:11
>To: Hogander Jouni (Nokia-D/Tampere)
>Cc: Kristo Tero (Nokia-D/Tampere); tony@atomide.com;=20
>linux-omap@vger.kernel.org
>Subject: Re: getnstimeofday() and suspend
>
>On Fri, 2008-08-15 at 12:55 +0300, H=F6gander Jouni wrote:
>
>> Using them both would also generate more complexity. What=20
>would be the=20
>> benefit in using them both?
>
>The RTC should be used during suspend since it's supposed to=20
>keep track of time regardless of how long the duration of the=20
>suspension is.
>
>The 32kHz alone is not a good generic solution since it=20
>overflows after a couple of days.

General problem seems to be that arch/arm has not defined =
read_persistent_clock() function. Attached patch tries to fix this =
problem by using a 32k counter hack. Probably something similar should =
be done which checks for overflows and uses RTC if available.

-Tero

------_=_NextPart_001_01C8FEC3.B0CE9EFA
Content-Type: application/octet-stream;
	name="0001-Fixed-timekeeping-bug-during-suspend.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Fixed-timekeeping-bug-during-suspend.patch
Content-Disposition: attachment;
	filename="0001-Fixed-timekeeping-bug-during-suspend.patch"

RnJvbSA3YWZkNWZhZDliMDdiNzc0YTg5ZGE3MzUyY2I1MjBhMGU0N2E5NWIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUZXJvIEtyaXN0byA8dGVyby5rcmlzdG9Abm9raWEuY29tPgpE
YXRlOiBGcmksIDE1IEF1ZyAyMDA4IDE1OjI1OjUxICswMzAwClN1YmplY3Q6IFtQQVRDSCAxLzFd
IEZpeGVkIHRpbWVrZWVwaW5nIGJ1ZyBkdXJpbmcgc3VzcGVuZAoKU2lnbmVkLW9mZi1ieTogVGVy
byBLcmlzdG8gPHRlcm8ua3Jpc3RvQG5va2lhLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LW9tYXAv
Y29tbW9uLmMgfCAgICA1ICsrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvY29tbW9uLmMg
Yi9hcmNoL2FybS9wbGF0LW9tYXAvY29tbW9uLmMKaW5kZXggM2E1ZjA1ZS4uYTYyZmM5NyAxMDA2
NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2NvbW1vbi5jCisrKyBiL2FyY2gvYXJtL3BsYXQt
b21hcC9jb21tb24uYwpAQCAtMjEwLDYgKzIxMCwxMSBAQCBzdGF0aWMgY3ljbGVfdCBvbWFwXzMy
a19yZWFkKHZvaWQpCiAJcmV0dXJuIG9tYXBfcmVhZGwoVElNRVJfMzJLX1NZTkNIUk9OSVpFRCk7
CiB9CiAKK3Vuc2lnbmVkIGxvbmcgcmVhZF9wZXJzaXN0ZW50X2Nsb2NrKHZvaWQpCit7CisgIHJl
dHVybiBvbWFwXzMya19yZWFkKCkgPj4gMTU7IAorfQorCiBzdGF0aWMgc3RydWN0IGNsb2Nrc291
cmNlIGNsb2Nrc291cmNlXzMyayA9IHsKIAkubmFtZQkJPSAiMzJrX2NvdW50ZXIiLAogCS5yYXRp
bmcJCT0gMjUwLAotLSAKMS41LjQuMwoK

------_=_NextPart_001_01C8FEC3.B0CE9EFA--
