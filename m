From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: [PATCH] OMAP audio DMA changes for 310 CPUs
Date: Tue, 12 Sep 2006 11:53:47 +0200
Message-ID: <fb249edb0609120253n41824aefub7eacde17cb5f452@mail.gmail.com>
References: <fb249edb0608180120m4d0786c7i6d4408112d7e2cf0@mail.gmail.com>
	<44E5F3CE.3010501@cc.jyu.fi>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_13009_6320465.1158054827540"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44E5F3CE.3010501@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lamikr@cc.jyu.fi
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_13009_6320465.1158054827540
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 18/08/06, lamikr <lamikr@cc.jyu.fi> wrote:
> Hi andrzej
>
> I have couple of questions from your patch.
> Your patch has couple of these changes where cpu_is_omap1510() has been
> changed to cpu_is_omap15xx().
>     -    if (!cpu_is_omap1510())
>     +    if (!cpu_is_omap15xx())
>
> Do they affect to the sound in omap 310? (I mean is cpu_is_omap15xx()
> true for your omap310)
> Or is following the only relevant omap310 specific change
>
>     +    } else if (cpu_is_omap310())
>     +        omap_start_dma(channel);
>
> Btw, your patch will not apply on top of all 5 patches I sent.
> Could you perhaps re-send it one more time? (I need also test whether
> your changes could work with omap1510/h6300)

Ok, this one applies on top of the five alsa patches. Sorry for the delay.

>
> Mika
>
> andrzej zaborowski wrote:
> > Avoid restarting McBSP hardware after every DMA transfer to OMAP audio
> > devices on OMAP310, restart only DMA. Also avoid trying to link DMA
> > channels together as this feature isn't supported on 310 processors.
> > Apply on top of "[PATCH 1/5] Change all omap15xx devices to use
> > similar DMA handling than h6300 uses".
> >
> > Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
>


-- 
balrog 2oo6

------=_Part_13009_6320465.1158054827540
Content-Type: application/octet-stream; name=linux-omap310-audio.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_es07fggh
Content-Disposition: attachment; filename="linux-omap310-audio.patch"

ZGlmZiAtLWdpdCBhL3NvdW5kL2FybS9vbWFwL29tYXAtYWxzYS1kbWEuYyBiL3NvdW5kL2FybS9v
bWFwL29tYXAtYWxzYS1kbWEuYwotLS0gYS9zb3VuZC9hcm0vb21hcC9vbWFwLWFsc2EtZG1hLmMK
KysrIGIvc291bmQvYXJtL29tYXAvb21hcC1hbHNhLWRtYS5jCkBAIC0yMDAsNyArMjAwLDcgQEAg
aW50IG9tYXBfcmVxdWVzdF9hbHNhX3NvdW5kX2RtYShpbnQgZGV2aQogCX0KIAogCS8qIENoYWlu
IHRoZSBjaGFubmVscyB0b2dldGhlciAqLwotCWlmICghY3B1X2lzX29tYXAxNTEwKCkpCisJaWYg
KCFjcHVfaXNfb21hcDE1eHgoKSkKIAkJb21hcF9zb3VuZF9kbWFfbGlua19sY2goZGF0YSk7CiAK
IAlzcGluX3VubG9jaygmZG1hX2xpc3RfbG9jayk7CkBAIC0yNTEsNyArMjUxLDcgQEAgaW50IG9t
YXBfZnJlZV9hbHNhX3NvdW5kX2RtYSh2b2lkICpkYXRhLAogCX0KIAljaGFuID0gKCpjaGFubmVs
cyk7CiAKLQlpZiAoIWNwdV9pc19vbWFwMTUxMCgpKQorCWlmICghY3B1X2lzX29tYXAxNXh4KCkp
CiAJCW9tYXBfc291bmRfZG1hX3VubGlua19sY2goZGF0YSk7CiAJZm9yIChpID0gMDsgaSA8IG5y
X2xpbmtlZF9jaGFubmVsczsgaSsrKSB7CiAJCWludCBjdXJfY2hhbiA9IGNoYW5baV07CkBAIC0z
NDksNyArMzQ5LDggQEAgc3RhdGljIGludCBhdWRpb19zdGFydF9kbWFfY2hhaW4oc3RydWN0IAog
CQlvbWFwX3N0YXJ0X2RtYShjaGFubmVsKTsKIAkJcy0+c3RhcnRlZCA9IDE7CiAJCXMtPmh3X3N0
YXJ0KCk7CSAgIC8qIHN0YXJ0IE1jQlNQIGludGVyZmFjZSAqLwotCX0KKwl9IGVsc2UgaWYgKGNw
dV9pc19vbWFwMzEwKCkpCisJCW9tYXBfc3RhcnRfZG1hKGNoYW5uZWwpOwogCS8qIGVsc2UgdGhl
IGRtYSBpdHNlbGYgd2lsbCBwcm9ncmVzcyBmb3J3YXJkIHdpdGggb3V0IG91ciBoZWxwICovCiAJ
Rk5fT1VUKDApOwogCXJldHVybiAwOwpkaWZmIC0tZ2l0IGEvc291bmQvYXJtL29tYXAvb21hcC1h
bHNhLmMgYi9zb3VuZC9hcm0vb21hcC9vbWFwLWFsc2EuYwotLS0gYS9zb3VuZC9hcm0vb21hcC9v
bWFwLWFsc2EuYworKysgYi9zb3VuZC9hcm0vb21hcC9vbWFwLWFsc2EuYwpAQCAtMjAzLDcgKzIw
Myw3IEBAIHN0YXRpYyB2b2lkIGF1ZGlvX3Byb2Nlc3NfZG1hKHN0cnVjdCBhdWQKIAkJICogaXJx
IGZyb20gRE1BIGFmdGVyIHRoZSBmaXJzdCB0cmFuc2ZlcmVkL3BsYXllZCBidWZmZXIuCiAJCSAq
IChpbnZvY2F0aW9uIG9mIGNhbGxiYWNrX29tYXBfYWxzYV9zb3VuZF9kbWEoKSBtZXRob2QpLgog
CQkgKi8KLQkJaWYgKGNwdV9pc19vbWFwMTV4eCgpKSB7CisJCWlmIChjcHVfaXNfb21hcDE1MTAo
KSkgewogCQkJb21hcF9zdG9wX2Fsc2Ffc291bmRfZG1hKHMpOwogCQl9CiAJCXJldCA9IG9tYXBf
c3RhcnRfYWxzYV9zb3VuZF9kbWEocywK
------=_Part_13009_6320465.1158054827540
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_13009_6320465.1158054827540--
