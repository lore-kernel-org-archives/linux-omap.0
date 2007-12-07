From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP2430: MUSB: Ethernet Gadget Issue
Date: Fri, 7 Dec 2007 14:38:56 -0600
Message-ID: <5573C19A4BBDB441BED2A44157E9705302C29F01@dlee12.ent.ti.com>
References: <5573C19A4BBDB441BED2A44157E9705302A4C387@dlee12.ent.ti.com>
	<200711231226.44592.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C83911.309AE0FE"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200711231226.44592.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83911.309AE0FE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Thanks for the email. Sorry for the delay but I got tied up with other
problems, though this is still a problem!=20

> the use of TTCP vs your test program matters.  TCP does
> have some flow control, afster all!


I wrote a similar test over the past few days to test TCP. I have found
that although it appears to take longer, it still ultimately fails at
some point. By fail, I mean that the transfers stop.


> A "cat /proc/driver/musb_hdrc" to see various state should
> be informative.


No probs. I have taken a cat of the above proc entry for both udp and
tcp case after the failure occurs. I am attaching the "dump" of the proc
entry for you to view. Let me know if you have any inputs on this. I am
not familiar enough to know how to interpret this info.

Cheers
Jon

------_=_NextPart_001_01C83911.309AE0FE
Content-Type: text/plain;
	name="musb_hdrc-tcp.txt"
Content-Transfer-Encoding: base64
Content-Description: musb_hdrc-tcp.txt
Content-Disposition: attachment;
	filename="musb_hdrc-tcp.txt"

U3RhdHVzOiBNSERSQywgTW9kZT1QZXJpcGhlcmFsIChQb3dlcj1mMCwgRGV2Q3RsPTk5KQpPVEcg
c3RhdGU6IGJfcGVyaXBoZXJhbDsgYWN0aXZlCk9wdGlvbnM6IG11c2ItZG1hLCBwZXJpcGhlcmFs
LCBkZWJ1Zz0xIFtlcHM9NV0KUGVyaXBoZXJhbCBhZGRyZXNzOiAxOQpHYWRnZXQgZHJpdmVyOiBl
dGhlcgoKZXAwIChodzApOiAxYnVmLCBjc3IgMDAwMCBtYXhwIDAwMDAKCShxdWV1ZSBlbXB0eSkK
CmVwMWluIChodzEpOiAxYnVmIGRtYSwgY3NyIGI0MDQgbWF4cCAwMjAwCglyZXEgYzFlNzRmNjAs
IHplcm8sIDAvMTA5MAoJcmVxIGMxZTc0YTIwLCB6ZXJvLCAwLzY2CglyZXEgYzFkMmExZTAsIHpl
cm8sIDAvNjYKCXJlcSBjMWU3NDNhMCwgemVybywgMC82NgoJcmVxIGMxZTc0MWEwLCB6ZXJvLCAw
LzE1MTQKCXJlcSBjMWU3NDEyMCwgemVybywgMC8xNTE0CglyZXEgYzFlNzQxNjAsIHplcm8sIDAv
MTUxNAoJcmVxIGMxZDJhMWEwLCB6ZXJvLCAwLzE1MTQKCXJlcSBjMWU3NGM2MCwgemVybywgMC8x
NTE0CglyZXEgYzFlNzQzZTAsIHplcm8sIDAvMTUxNAoKZXAxb3V0IChodzEpOiAxYnVmIGRtYSwg
Y3NyIDIwMDMgbWF4cCAwMjAwCglyZXEgYzFlNzQ3YTAsIDUxMi8xNTM2CglyZXEgYzFlNzQ2YTAs
IDAvMTUzNgoJcmVxIGMxZTc0NjYwLCAwLzE1MzYKCXJlcSBjMWU3NGZhMCwgMC8xNTM2CglyZXEg
YzFlNzQyYTAsIDAvMTUzNgoJcmVxIGMxZTc0NWEwLCAwLzE1MzYKCXJlcSBjMWU3NDc2MCwgMC8x
NTM2CglyZXEgYzFlNzQyMjAsIDAvMTUzNgoJcmVxIGMxZTc0ZjIwLCAwLzE1MzYKCXJlcSBjMWQy
YTdlMCwgMC8xNTM2CgplcDJpbiAoaHcyKTogMWJ1ZiBkbWEsIGNzciAyMDA0IG1heHAgMDAxMAoJ
KHF1ZXVlIGVtcHR5KQo=

------_=_NextPart_001_01C83911.309AE0FE
Content-Type: text/plain;
	name="musb_hdrc-udp.txt"
Content-Transfer-Encoding: base64
Content-Description: musb_hdrc-udp.txt
Content-Disposition: attachment;
	filename="musb_hdrc-udp.txt"

U3RhdHVzOiBNSERSQywgTW9kZT1QZXJpcGhlcmFsIChQb3dlcj1mMCwgRGV2Q3RsPTk5KQpPVEcg
c3RhdGU6IGJfcGVyaXBoZXJhbDsgYWN0aXZlCk9wdGlvbnM6IG11c2ItZG1hLCBwZXJpcGhlcmFs
LCBkZWJ1Zz0xIFtlcHM9NV0KUGVyaXBoZXJhbCBhZGRyZXNzOiAxMQpHYWRnZXQgZHJpdmVyOiBl
dGhlcgoKZXAwIChodzApOiAxYnVmLCBjc3IgMDAwMCBtYXhwIDAwMDAKCShxdWV1ZSBlbXB0eSkK
CmVwMWluIChodzEpOiAxYnVmIGRtYSwgY3NyIGI0MDQgbWF4cCAwMjAwCglyZXEgYzFlOWE3NjAs
IHplcm8sIDAvMTA2NgoJcmVxIGMxZTlhNzIwLCB6ZXJvLCAwLzEwNjYKCXJlcSBjMWU5YWZhMCwg
emVybywgMC8xMDY2CglyZXEgYzFlOWE4MjAsIHplcm8sIDAvMTA2NgoJcmVxIGMxZTlhN2UwLCB6
ZXJvLCAwLzEwNjYKCXJlcSBjMWU5YTdhMCwgemVybywgMC8xMDY2CglyZXEgYzFkMWU1YTAsIHpl
cm8sIDAvMTA2NgoJcmVxIGMxZDFlNWUwLCB6ZXJvLCAwLzEwNjYKCXJlcSBjMWQxZTU2MCwgemVy
bywgMC8xMDY2CglyZXEgYzFlOWE0ZTAsIHplcm8sIDAvMTA2NgoKZXAxb3V0IChodzEpOiAxYnVm
IGRtYSwgY3NyIDIwMDMgbWF4cCAwMjAwCglyZXEgYzFlOWE4ZTAsIDUxMi8xNTM2CglyZXEgYzFl
OWE5MjAsIDAvMTUzNgoJcmVxIGMxZTlhNTYwLCAwLzE1MzYKCXJlcSBjMWU5YTQyMCwgMC8xNTM2
CglyZXEgYzFlOWEyYTAsIDAvMTUzNgoJcmVxIGMxZTlhNDYwLCAwLzE1MzYKCXJlcSBjMWU5YTUy
MCwgMC8xNTM2CglyZXEgYzFlOWEzNjAsIDAvMTUzNgoJcmVxIGMxZTlhODYwLCAwLzE1MzYKCXJl
cSBjMWU5YThhMCwgMC8xNTM2CgplcDJpbiAoaHcyKTogMWJ1ZiBkbWEsIGNzciAyMDA0IG1heHAg
MDAxMAoJKHF1ZXVlIGVtcHR5KQo=

------_=_NextPart_001_01C83911.309AE0FE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C83911.309AE0FE--
