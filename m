From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Wed, 24 Mar 2010 20:15:14 +0200
Message-ID: <94a0d4531003241115i7b11af8cqb00b478afeb86297@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
	 <94a0d4531003190451h23ad1a16x994973cdfeb3c83f@mail.gmail.com>
	 <94a0d4531003190853y7b6bda0dg6db8ab263bbb8532@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044DE0E3DE@dbde02.ent.ti.com>
	 <94a0d4531003190918v7e943d5ax16baf6945472530c@mail.gmail.com>
	 <94a0d4531003191200r425652c3ybf505c353b2ad847@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CACBD655@dlee06.ent.ti.com>
	 <94a0d4531003191511q6135a424r9ce68c632cc826dd@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CACBD669@dlee06.ent.ti.com>
	 <496565EC904933469F292DDA3F1663E602CACBDF08@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517479260723fde04828fe991
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:45355 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512Ab0CXSPR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 14:15:17 -0400
Received: by bwz1 with SMTP id 1so180400bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 11:15:15 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CACBDF08@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Hebbar, Shivananda" <x0hebbar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

--001517479260723fde04828fe991
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 23, 2010 at 9:29 PM, Guzman Lugo, Fernando <x0095840@ti.com> wrote:
> I have tested just using an application (base on bridged code) which is registered for fatal events and once it receives an event it prints the received event:

Ok, I ran your test and it works, however, I tried to modify it to fit
what I'm doing in gst-dsp and it turns out it's very easy for this
code to reboot the device. I'm attaching the test.

Also, I found the exact reason why my code fails but yours not. I do
something like this:

while (!done) {
  dsp_wait_for_events(&index);

  if (index == 0) {
    /* node message */
    while (true) {
      if (!dsp_node_get_message(&msg))
        break;
      handle_message(msg);
    }
  }
}

So, before your patch, the get_message() failed, and the next
wait_for_events() succeeded and returned the MMU fault. Now, the
get_message() fails, and so does the wait_for_events().

The only way to make that code work with your patch is to remove the
inner while, so wait_for_events() and get_message() are always run one
after the other.

That is breaking old behavior and should be fixed, right?

-- 
Felipe Contreras

--001517479260723fde04828fe991
Content-Type: text/x-csrc; charset=US-ASCII; name="reboot.c"
Content-Disposition: attachment; filename="reboot.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g76geymm1

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KCiNpbmNsdWRlIDxkYmFwaS5o
PgoKI2RlZmluZSBBUlJBWV9TSVpFKGFycikgKHNpemVvZihhcnIpIC8gc2l6ZW9mKChhcnIpWzBd
KSkKCnN0YXRpYyBjaGFyICplX25hbWVbXSA9IHsgIk1NVV9GQVVMVCIsICJTWVNfRVJST1IiLCAi
UFdSX0VSUk9SIiwgIlNUQVRFX0NIQU5HRSIsICJVTktOT1dOIiB9OwoKdm9pZCBicmlkZ2VfbGlz
dGVuZXIodm9pZCkKewoJRFNQX0hQUk9DRVNTT1IgcHJvYzsKCXVuc2lnbmVkIGluZGV4ID0gMCwg
aTsKCWxvbmcgc3RhdHVzOwoJc3RydWN0IERTUF9OT1RJRklDQVRJT04gKmV2ZW50c1szXTsKCglm
b3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShldmVudHMpOyBpKyspCgkJZXZlbnRzW2ldID0gY2Fs
bG9jKDEsIHNpemVvZigqKmV2ZW50cykpOwoKCXN0YXR1cyA9IERzcE1hbmFnZXJfT3BlbigwLCBO
VUxMKTsKCWlmIChzdGF0dXMgPCAwKSB7CgkJcHJpbnRmKCJvcGVuIGZhaWxlZFxuIik7CgkJZ290
byBvdXQ7Cgl9CgoJc3RhdHVzID0gRFNQUHJvY2Vzc29yX0F0dGFjaCgwLCBOVUxMLCAmcHJvYyk7
CglpZiAoc3RhdHVzIDwgMCkgewoJCXByaW50ZigiYXR0YWNoIGZhaWxlZFxuIik7CgkJZ290byBv
dXQ7Cgl9CgoJc3RhdHVzID0gRFNQUHJvY2Vzc29yX1JlZ2lzdGVyTm90aWZ5KHByb2MsIERTUF9N
TVVGQVVMVCwgRFNQX1NJR05BTEVWRU5ULCBldmVudHNbMF0pOwoJaWYgKHN0YXR1cyA8IDApIHsK
CQlwcmludGYoInJlZ2lzdGVyIG1tdSBmYXVsdCBmYWlsZWRcbiIpOwoJCWdvdG8gb3V0OwoJfQoK
CXN0YXR1cyA9IERTUFByb2Nlc3Nvcl9SZWdpc3Rlck5vdGlmeShwcm9jLCBEU1BfU1lTRVJST1Is
IERTUF9TSUdOQUxFVkVOVCwgZXZlbnRzWzFdKTsKCWlmIChzdGF0dXMgPCAwKSB7CgkJcHJpbnRm
KCJyZWdpc3RlciBzeXMgZXJyb3IgZmFpbGVkXG4iKTsKCQlnb3RvIG91dDsKCX0KCglzdGF0dXMg
PSBEU1BNYW5hZ2VyX1dhaXRGb3JFdmVudHMoZXZlbnRzLCBBUlJBWV9TSVpFKGV2ZW50cyksICZp
bmRleCwgRFNQX0ZPUkVWRVIpOwoJaWYgKHN0YXR1cyA+PSAwKQoJCXByaW50ZigiZXZlbnQgcmVj
ZWl2ZWQgJXNcbiIsIGVfbmFtZVtpbmRleF0pOwoJZWxzZQoJCXByaW50Zigid2FpdCBmb3IgZXZl
bnRzIGZhaWxlZFxuIik7CgpvdXQ6CglEU1BQcm9jZXNzb3JfRGV0YWNoKHByb2MpOwoJRHNwTWFu
YWdlcl9DbG9zZSgwLCBOVUxMKTsKCglmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShldmVudHMp
OyBpKyspCgkJZnJlZShldmVudHNbaV0pOwp9CgppbnQgbWFpbih2b2lkKQp7CglicmlkZ2VfbGlz
dGVuZXIoKTsKCglyZXR1cm4gMDsKfQo=
--001517479260723fde04828fe991--
