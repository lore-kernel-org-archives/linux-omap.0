From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: dss2 for-next BUG at drivers/video/omap2/dss/core.c:323!
Date: Mon, 24 May 2010 12:02:00 -0500
Message-ID: <AANLkTimy4PLEJ7LtnO79nF_NbMUrpIvfhfGJeg-MUPl4@mail.gmail.com>
References: <AANLkTinS0irEdEzttaHd0n_w5Cs3h6Q44e9sXgcbDmNH@mail.gmail.com>
	 <1274169334.2307.74.camel@tubuntu.research.nokia.com>
	 <AANLkTilySmQn2w0royR2UXltWt4Y94AAU-EYXvny9Se1@mail.gmail.com>
	 <AANLkTikEouEjWyu9De6hAweyEGXx6drV4E18zWyC_CRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00032555e49ed42b3e048759ffae
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41818 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757828Ab0EXRCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 13:02:03 -0400
Received: by bwz7 with SMTP id 7so1112101bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 10:02:00 -0700 (PDT)
In-Reply-To: <AANLkTikEouEjWyu9De6hAweyEGXx6drV4E18zWyC_CRg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ville Syrjala <ville.syrjala@nokia.com>

--00032555e49ed42b3e048759ffae
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2010 at 12:12 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, May 18, 2010 at 3:34 PM, Robert Nelson <robertcnelson@gmail.com> =
wrote:
>> On Tue, May 18, 2010 at 2:55 AM, Tomi Valkeinen
>> <tomi.valkeinen@nokia.com> wrote:
>>> On Mon, 2010-05-17 at 16:30 +0200, ext Robert Nelson wrote:
>>>> Hi Tomi,
>>>>
>>>> I've been using your dss2 branch with much success.
>>>>
>>>> http://gitorious.org/linux-omap-dss2/linux/commits/for-next
>>>>
>>>> I've just ran into a weird BUG that occurs on reboot on my headless
>>>> beagles and wondering if you've ran into it too...
>>>>
>>>> The kernel I'm currently testing is 2.6.34-rc7 plus the 2.6.35 dss2
>>>> for-next commits..
>>>>
>>>> I was assuming http://gitorious.org/linux-omap-dss2/linux/commit/89627=
989c6b4408c4578a41bcd5f9d04545797ad
>>>> would fix it, but it hasn't fixed the Opps'ing...
>>>>
>>>> log on attempt to reboot:
>>>>
>>>> http://pastebin.com/iqAHMVD4
>>>
>>> It looks like there's a mismatch with clock enables and disables
>>> somewhere... I haven't seen that.
>>>
>>> Can you tell me more details of your beagle? Does "headless" mean that
>>> it's standard beagle board, but no display is connected to it?
>>
>> Correct, just a beagle with no display connected..
>>
>> I upgraded to 2.6.34 final plus dss2 for-next and enabled omapfb.debug
>> and a generic modesetting to see if would make any difference in the
>> bootargs. =A0Same result..
>>
>> http://www.pastie.org/965380
>>
>> I should also mention, this only occurs after a small length of time
>> (about 10 minutes).. I can't seem to trigger it after a frresh reboot
>> (1-2 minutes)..

After 10mins, the display enters dpms mode (suspend) neither ssh or
serial activity will resume the display. (not a bug, usb
mouse/keyboard will of course awaken it..)

But when reboot is called, it doesn't handle the display correctly
when it's suspended..  By simply un-suspending the display from
suspend the bug goes away.. Not sure on the best method to detect this
situation, but the attached quick patch seems to fix it on my beagles
using generic_panel_disable...

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/

--00032555e49ed42b3e048759ffae
Content-Type: text/x-patch; charset=US-ASCII; name="reboot-fix.diff"
Content-Disposition: attachment; filename="reboot-fix.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9ljlj7m0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vb21hcDIvZGlzcGxheXMvcGFuZWwtZ2VuZXJpYy5j
IGIvZHJpdmVycy92aWRlby9vbWFwMi9kaXNwbGF5cy9wYW5lbC1nZW5lcmljLmMKaW5kZXggMzAw
ZWZmNS4uYjRiMTk3MCAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9vbWFwMi9kaXNwbGF5cy9w
YW5lbC1nZW5lcmljLmMKKysrIGIvZHJpdmVycy92aWRlby9vbWFwMi9kaXNwbGF5cy9wYW5lbC1n
ZW5lcmljLmMKQEAgLTkxLDYgKzkxLDE4IEBAIHN0YXRpYyBpbnQgZ2VuZXJpY19wYW5lbF9lbmFi
bGUoc3RydWN0IG9tYXBfZHNzX2RldmljZSAqZHNzZGV2KQogCiBzdGF0aWMgdm9pZCBnZW5lcmlj
X3BhbmVsX2Rpc2FibGUoc3RydWN0IG9tYXBfZHNzX2RldmljZSAqZHNzZGV2KQogeworCisJaWYg
KGRzc2Rldi0+c3RhdGUgPT0gT01BUF9EU1NfRElTUExBWV9TVVNQRU5ERUQpCisJeworCQlpbnQg
ciA9IDA7CisKKwkJciA9IGdlbmVyaWNfcGFuZWxfcG93ZXJfb24oZHNzZGV2KTsKKwkJaWYgKHIp
CisJCQlyZXR1cm4gcjsKKworCQlkc3NkZXYtPnN0YXRlID0gT01BUF9EU1NfRElTUExBWV9BQ1RJ
VkU7CisJfQorCiAJZ2VuZXJpY19wYW5lbF9wb3dlcl9vZmYoZHNzZGV2KTsKIAogCWRzc2Rldi0+
c3RhdGUgPSBPTUFQX0RTU19ESVNQTEFZX0RJU0FCTEVEOwo=
--00032555e49ed42b3e048759ffae--
