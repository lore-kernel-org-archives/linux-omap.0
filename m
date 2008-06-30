From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: FW: [PATCH 00/05] 34XX cpu idle patches - core off
Date: Mon, 30 Jun 2008 07:45:37 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BB6ED25@dlee02.ent.ti.com>
References: <008101c8d091$27d64bd0$68bf18ac@ent.ti.com>
 <20080619114823.GB4953@codecarver.research.nokia.com>
 <001d01c8d203$5cac7500$68bf18ac@ent.ti.com>
 <20080619120507.GC4953@codecarver.research.nokia.com>
 <001e01c8d205$a89ed4b0$68bf18ac@ent.ti.com>
 <20080623144018.GC4468@codecarver.research.nokia.com>
 <008201c8d84d$0577d540$68bf18ac@ent.ti.com>
 <20080630104345.GC4379@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_13B9B4C6EF24D648824FF11BE8967162035BB6ED25dlee02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56681 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbYF3Mpv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2008 08:45:51 -0400
In-Reply-To: <20080630104345.GC4379@codecarver.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>, "Sawant, Anand" <sawant@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_13B9B4C6EF24D648824FF11BE8967162035BB6ED25dlee02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > I am still seeing some issues with debug uart responsiveness which I
> am looking into. Need to see if the wakeup

If by responsiveness it is meant slowness of output (tx path) that' likely =
good news.  It means your hitting interconnect clock stop often and thus ge=
tting into first large active mode savings state.  This is the biggest step=
 power drop for active states.  If your UART looks good you probably are no=
t hitting target states enough from idle.

The UART's TX logic is not currently hooked into the wake up mechanism from=
 clockstop (domain INACTIVE but ON, only RX an external IO events).  As suc=
h to get good speed you need go to no-idle if there is TX work queued else =
you won't see TX interrupt events until the next wake up period, likely fro=
m GPTIMER0 at dynamic tick rate.

* Expect to loose the 1st character on debug console as a wake up event.  U=
nless you use RTS/CTS (configured as wakeups) as an early wake up path, you=
 will lose the start bit when the system restarts.  For things like bluetoo=
th or other the protocol should re-transmit.

If you mean your not waking that's something else.

I've attached a simple path which make UART responsive during high idle per=
iods.  It makes the PRCM handshake follow the UART transmitter state.  You =
miss out on clock stop during FIFO drain time but that's not so much % wise=
 in debug usage.  An optimal alternative is to set a kernel TIMER to fire a=
t about the expected TX empty time.  This will make sure GPT0 wake up will =
fire.  This will allow FIFO drain while in interconnect clock stop.

Regards,
Richard W.


--_002_13B9B4C6EF24D648824FF11BE8967162035BB6ED25dlee02enttico_
Content-Type: application/octet-stream; name="uart_fast5.diff"
Content-Description: uart_fast5.diff
Content-Disposition: attachment; filename="uart_fast5.diff"; size=1126;
	creation-date="Mon, 30 Jun 2008 07:29:08 GMT";
	modification-date="Mon, 30 Jun 2008 07:29:08 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtcHVyTiBpbWcvMi42X2tlcm5lbC9kcml2ZXJzL3NlcmlhbC84MjUwLmMgMi42X2tlcm5l
bC9kcml2ZXJzL3NlcmlhbC84MjUwLmMKLS0tIGltZy8yLjZfa2VybmVsL2RyaXZlcnMvc2VyaWFs
LzgyNTAuYwkyMDA4LTA1LTA5IDE4OjUwOjUzLjAwMDAwMDAwMCAtMDUwMAorKysgMi42X2tlcm5l
bC9kcml2ZXJzL3NlcmlhbC84MjUwLmMJMjAwOC0wNi0wMyAxOTo0NDoyNC4wMDAwMDAwMDAgLTA1
MDAKQEAgLTEyMjEsNiArMTIyMSwxNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19zdG9wX3R4KHN0
cnVjdCB1YXJ0CiAJCXAtPmllciAmPSB+VUFSVF9JRVJfVEhSSTsKIAkJc2VyaWFsX291dChwLCBV
QVJUX0lFUiwgcC0+aWVyKTsKIAl9CisjaWZkZWYgQ09ORklHX09NQVAzX1BNCisJeworCQkvKiBB
ZHZlcnRpc2UgcGFydGlhbCBpZGxlIHRvIHNhdmUgcG93ZXIuIFJYIHNpZGUgY2FuIGRvIGFzeW5j
IHdha2UgKi8KKwkJdW5zaWduZWQgaW50IHRtcDsKKwkJdG1wID0gKHNlcmlhbF9pbihwLCBVQVJU
X09NQVBfU1lTQykgJiAweDcpIHwgKDIgPDwgMyk7CisJCXNlcmlhbF9vdXQocCwgVUFSVF9PTUFQ
X1NZU0MsIHRtcCk7IC8qIHNtYXJ0LWlkbGUgKi8KKwl9CisjZW5kaWYKIH0KIAogc3RhdGljIHZv
aWQgc2VyaWFsODI1MF9zdG9wX3R4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCkBAIC0xMjY4LDYg
KzEyNzYsMTUgQEAgc3RhdGljIHZvaWQgc2VyaWFsODI1MF9zdGFydF90eChzdHJ1Y3QgdQogCQl1
cC0+YWNyICY9IH5VQVJUX0FDUl9UWERJUzsKIAkJc2VyaWFsX2ljcl93cml0ZSh1cCwgVUFSVF9B
Q1IsIHVwLT5hY3IpOwogCX0KKyNpZmRlZiBDT05GSUdfT01BUDNfUE0KKwl7CisJCS8qIERvbid0
IGFkdmVydGlzZSBwYXJ0aWFsIGlkbGUgZWxzZSBUWCBpcnFzIHdpbGwgbm90IGJlIHNlZW4gKi8K
KwkJLyogQWx0ZXJuYXRpdmUgaXMgdG8gc2V0IGtlcm5lbCB0aW1lciBhdCBmaWZvIGRyYWluIHJh
dGUgKi8KKwkJdW5zaWduZWQgaW50IHRtcDsKKwkJdG1wID0gKHNlcmlhbF9pbih1cCwgVUFSVF9P
TUFQX1NZU0MpICYgMHg3KSB8ICgxIDw8IDMpOworCQlzZXJpYWxfb3V0KHVwLCBVQVJUX09NQVBf
U1lTQywgdG1wKTsgLyogbm8taWRsZSAqLworCX0KKyNlbmRpZgogfQogCg==

--_002_13B9B4C6EF24D648824FF11BE8967162035BB6ED25dlee02enttico_--
