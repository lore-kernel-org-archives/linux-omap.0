From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Nokia Internet Tablets
Date: Tue, 23 Dec 2008 09:34:45 +0200
Message-ID: <20081223093445.69d761e5.jarkko.nikula@nokia.com>
References: <20081222103422.GL29448@guug.org>
	<20081222140137.GD12324@swansys>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__23_Dec_2008_09_34_45_+0200_bqCClFhXxDKgwn.M"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52955 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbYLWHfL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 02:35:11 -0500
In-Reply-To: <20081222140137.GD12324@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext green <greenfreedom10@gmail.com>
Cc: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__23_Dec_2008_09_34_45_+0200_bqCClFhXxDKgwn.M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2008 08:01:37 -0600
"ext green" <greenfreedom10@gmail.com> wrote:

> This is great; I hope you have success.  I (who am new to kernel development 
> and git) have an N810 and have been trying to get Debian running on it usably; 
> I do have Debian running, but: no X, no RTC, no audio, and a very short idle 
> time (on a charge).  Unfortunately I have little free time in which to work on 
> it.
> 
I recently tried xserver-xorg-video-fbdev from Debian/testing and got it
working just by adding 'Option "UseFBDev" "true"' in Section "Devices".
My xorg.conf attached.

Audio note (after "make n800_defconfig):

Device Drivers ->
 Sound card support ->
  Advanced Linux Sound Architecture ->
    ALSA for SoC audio support ->
     SoC Audio for the Texas Instruments OMAP chips
     SoC Audio support for Nokia N810

And especially this:

System Type ->
 TI OMAP Implementations ->
  OMAP multiplexing support

This is because N810 bootloader muxes audio I2S pins for OMAP2420 EAC
block but ASoC drivers are using McBSP block so those pins must be
remuxed by the kernel.


Jarkko

--Multipart=_Tue__23_Dec_2008_09_34_45_+0200_bqCClFhXxDKgwn.M
Content-Type: application/octet-stream;
 name="xorg.conf"
Content-Disposition: attachment;
 filename="xorg.conf"
Content-Transfer-Encoding: base64

IyB4b3JnLmNvbmYgKFguT3JnIFggV2luZG93IFN5c3RlbSBzZXJ2ZXIgY29uZmlndXJhdGlvbiBm
aWxlKQojCiMgVGhpcyBmaWxlIHdhcyBnZW5lcmF0ZWQgYnkgZGV4Y29uZiwgdGhlIERlYmlhbiBY
IENvbmZpZ3VyYXRpb24gdG9vbCwgdXNpbmcKIyB2YWx1ZXMgZnJvbSB0aGUgZGViY29uZiBkYXRh
YmFzZS4KIwojIEVkaXQgdGhpcyBmaWxlIHdpdGggY2F1dGlvbiwgYW5kIHNlZSB0aGUgeG9yZy5j
b25mIG1hbnVhbCBwYWdlLgojIChUeXBlICJtYW4geG9yZy5jb25mIiBhdCB0aGUgc2hlbGwgcHJv
bXB0LikKIwojIFRoaXMgZmlsZSBpcyBhdXRvbWF0aWNhbGx5IHVwZGF0ZWQgb24geHNlcnZlci14
b3JnIHBhY2thZ2UgdXBncmFkZXMgKm9ubHkqCiMgaWYgaXQgaGFzIG5vdCBiZWVuIG1vZGlmaWVk
IHNpbmNlIHRoZSBsYXN0IHVwZ3JhZGUgb2YgdGhlIHhzZXJ2ZXIteG9yZwojIHBhY2thZ2UuCiMK
IyBJZiB5b3UgaGF2ZSBlZGl0ZWQgdGhpcyBmaWxlIGJ1dCB3b3VsZCBsaWtlIGl0IHRvIGJlIGF1
dG9tYXRpY2FsbHkgdXBkYXRlZAojIGFnYWluLCBydW4gdGhlIGZvbGxvd2luZyBjb21tYW5kOgoj
ICAgc3VkbyBkcGtnLXJlY29uZmlndXJlIC1waGlnaCB4c2VydmVyLXhvcmcKClNlY3Rpb24gIklu
cHV0RGV2aWNlIgoJSWRlbnRpZmllcgkiR2VuZXJpYyBLZXlib2FyZCIKCURyaXZlcgkJImtiZCIK
CU9wdGlvbgkJIlhrYlJ1bGVzIgkieG9yZyIKCU9wdGlvbgkJIlhrYk1vZGVsIgkicGMxMDQiCglP
cHRpb24JCSJYa2JMYXlvdXQiCSJ1cyIKRW5kU2VjdGlvbgoKU2VjdGlvbiAiSW5wdXREZXZpY2Ui
CglJZGVudGlmaWVyCSJDb25maWd1cmVkIE1vdXNlIgoJRHJpdmVyCQkibW91c2UiCkVuZFNlY3Rp
b24KClNlY3Rpb24gIkRldmljZSIKCUlkZW50aWZpZXIJIkNvbmZpZ3VyZWQgVmlkZW8gRGV2aWNl
IgoJRHJpdmVyCQkiZmJkZXYiCglPcHRpb24JCSJVc2VGQkRldiIJCSJ0cnVlIgpFbmRTZWN0aW9u
CgpTZWN0aW9uICJNb25pdG9yIgoJSWRlbnRpZmllcgkiQ29uZmlndXJlZCBNb25pdG9yIgpFbmRT
ZWN0aW9uCgpTZWN0aW9uICJTY3JlZW4iCglJZGVudGlmaWVyCSJEZWZhdWx0IFNjcmVlbiIKCU1v
bml0b3IJCSJDb25maWd1cmVkIE1vbml0b3IiCkVuZFNlY3Rpb24KClNlY3Rpb24gIlNlcnZlckZs
YWdzIgoJT3B0aW9uCSJCbGFua1RpbWUiCSIwIgoJT3B0aW9uCSJTdGFuZGJ5VGltZSIJIjAiCglP
cHRpb24JIlN1c3BlbmRUaW1lIgkiMSIKCU9wdGlvbgkiT2ZmVGltZSIJIjAiCkVuZFNlY3Rpb24K

--Multipart=_Tue__23_Dec_2008_09_34_45_+0200_bqCClFhXxDKgwn.M--
