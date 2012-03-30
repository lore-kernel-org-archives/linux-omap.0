From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Fri, 30 Mar 2012 14:16:45 +0530
Message-ID: <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
References: <CAMrsUdKXZL4nT0MW=BcD53PsQFE+W1inij3XWe0e5+BjJF3odg@mail.gmail.com>
 <WC20120328153855.621724@terrafix.co.uk> <87vcloipow.fsf@ti.com>
 <WC20120329083556.20174D@terrafix.co.uk> <alpine.DEB.2.00.1203290356190.2788@utopia.booyaka.com>
 <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk>
 <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com> <WC20120330075339.4017FC@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae93993d19be1d704bc71e228
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:57047 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759611Ab2C3IrH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 04:47:07 -0400
Received: by obbef5 with SMTP id ef5so733947obb.7
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 01:47:06 -0700 (PDT)
In-Reply-To: <WC20120330075339.4017FC@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

--14dae93993d19be1d704bc71e228
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2012 at 1:23 PM, Joe Woodward <jw@terrafix.co.uk> wrote:
> -----Original Message-----
> From: "Raja, Govindraj" <govindraj.raja@ti.com>
> To: Joe Woodward <jw@terrafix.co.uk>
> Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-=
omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de
> Date: Thu, 29 Mar 2012 19:59:54 +0530
> Subject: Re: Suspend broken on 3.3?
>
>> On Thu, Mar 29, 2012 at 5:10 PM, Joe Woodward <jw@terrafix.co.uk>
>> wrote:
>> >
>> >
>> > -----Original Message-----
>> > From: "Joe Woodward" <jw@terrafix.co.uk>
>> > To: "Paul Walmsley" <paul@pwsan.com>
>> > Cc: "Kevin Hilman" <khilman@ti.com>, "Raja\\, Govindraj"
>> <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, "Felipe Balbi"
>> <balbi@ti.com>, neilb@suse.de
>> > Date: Thu, 29 Mar 2012 12:27:55 +0100
>> > Subject: Re: Suspend broken on 3.3?
>> >
>> >> > Hello Joe,
>> >> >
>> >> > thanks for reporting this. =A0Some thoughts -- really just pure
>> >> > speculation
>> >> > -- but I hope some of it might be useful for you...
>> >> >
>> >> > On Thu, 29 Mar 2012, Joe Woodward wrote:
>> >> >
>> >> > > After digging a bit further I found that the problem isn't lost
>> >> > characters or character corruption at all...
>> >> > >
>> >> > > The UART is actually at 430KBaud (not 900KBaud as I mentioned
>> >> > earlier).
>> >> >
>> >> > 430Kbps? =A0Could you confirm this? =A0OMAP UARTs don't support tha=
t
>> rate
>> >> > as
>> >> > far as I know - the closest is 460Kbps (OMAP34xx TRM vZR Table
>> 17-1
>> >> > "UART
>> >> > Mode Baud Rates, Divisor Values, and Error Rates). =A0If one was
>> >> > desperate,
>> >> > it might be possible to get 430Kbps by tweaking other parts of the
>> >> > clock
>> >> > tree though...
>> >>
>> >> Sorry for the confusion... It's 460KBaud - the 430 was just a typo
>> in
>> >> my previous mail...
>> >>
>> >> >
>> >> > > The data received is very bursty (i.e. sets of messages every
>> >> second
>> >> > or
>> >> > > so), containing a sync sequence to indicate a start of packet.
>> >> > >
>> >> > > The received bytes should be: 0x01, 0x52, 0x41 ....rest of
>> packet.
>> >> > >
>> >> > > This works 100% of the time on 3.2, but on 3.3 I sometimes (but
>> not
>> >> > always) get: 0x01, 0x00, 0x52, 0x41.
>> >> > >
>> >> > > i.e. there is a NULL/0x00 inserted after the first character.
>> >> >
>> >> > Is this on the serial console, or on a non-console serial port?
>> >> >
>> >> > Looking at drivers/tty/serial/omap-serial.c:receive_chars(), I
>> wonder
>> >> > if
>> >> > the driver is somehow reading bytes from the RX FIFO when it's
>> empty.
>> >>
>> >> > It's unclear to me how this could happen. =A0But you might want to
>> try
>> >> > doing
>> >> > an LSR read right before entering the loop in
>> >> > drivers/tty/serial/omap-serial.c:receive_chars(). =A0In stock v3.3,
>> >> this
>> >> > would mean adding
>> >> >
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 lsr =3D serial_in(up, UART_LSR);
>> >> >
>> >> > at line 190 of drivers/tty/serial/omap-serial.c.
>> >> >
>> >>
>> >> Adding this is made no obvious difference.
>> >>
>> >> >
>> >> > You might also try the DMA path as an experiment. =A0This will
>> totally
>> >> > wedge
>> >> > power management due to an insanely low timer expiration in that
>> >> path,
>> >> > but
>> >> > at least might help narrow the problem down. =A0To do so with a
>> quick
>> >> > hack,
>> >> > you could set omap_serial_default_info.dma_enabled to true instead
>> of
>> >> > false at arch/arm/mach-omap2/serial.c:76.
>> >> >
>> >>
>> >> This did the trick (I've added it in addition to the LSR read above,
>> >> i'll back out the LSR read and see if it still works).
>> >> When DMA is enabled the behaviour (as seen from my application in
>> >> userspace) is the same as on the stock 3.2 kernel (i.e. for me it
>> works
>> >> :) ).
>> >>
>> >
>> > I've just realised that if anyone has joined this thread late, then
>> I'm running in a state with Govindraj's patch in a previous mail in
>> this thread applied to serial.c to
>> > fix the suspend issues due to the UART wakeup's not being correctly
>> changed from userspace via sysfs.
>> >
>> > It may actually by this patch that is causing the interrupt-enabled
>> serial driver to have broken? The tty that is causing me a problem does
>> have wake-from-suspend
>> > disabled for it from userspace...
>>
>> Is the patch shared earlier causing this issue of getting 0x00 from rx
>> randomly ?
>>
>
> In short, yes.
>
> I've gone back to a stock 3.3 kernel and the serial ports give the correc=
t data, but suspend fails (due to not being able to disable wake-from-seria=
l).
>
> I then applied your patch and could disable wakeup on the serial ports an=
d suspend correctly, but the (non-console) serial port starts to misbehave.
>
> Forcing the driver to be DMA-enabled caused everything to work again. So =
something in the patch is causing the (default) interrupt-enabled serial dr=
iver to
> occassionally fail.
>

Disabling module level wakeup by default on bootup in previous shared patch
in serial.c in omap_uart_idle_init =3D> omap_uart_disable_module_wakeup
might be causing this issue and probably this should be left enabled by def=
ault
and be disabled only when requested from sysfs on suspend.

Could you please try attached patch and let me know if this solves the
rx issue as well,
without using dma mode.

--
Thanks,
Govindraj.R

--14dae93993d19be1d704bc71e228
Content-Type: application/octet-stream;
	name="0001-OMAP2-UART-Correct-the-module-level-wakeup-enable-di.patch"
Content-Disposition: attachment;
	filename="0001-OMAP2-UART-Correct-the-module-level-wakeup-enable-di.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0ezlrbk0

RnJvbSA2YTUxNDMxMTA0MDVjZTM5N2I1OTQxYjc1NjA0MWVjYzZlMWYwNTYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiR292aW5kcmFqLlIiIDxnb3ZpbmRyYWoucmFqYUB0aS5jb20+
CkRhdGU6IFR1ZSwgMjcgTWFyIDIwMTIgMTg6NTU6MDAgKzA1MzAKU3ViamVjdDogW1BBVENIXSBP
TUFQMis6IFVBUlQ6IENvcnJlY3QgdGhlIG1vZHVsZSBsZXZlbCB3YWtldXAgZW5hYmxlL2Rpc2Fi
bGUKIG1lY2hhbmlzbQoKVGhlIGNvbW1pdCAoNjJmM2VjNSAgQVJNOiBPTUFQMis6IFVBUlQ6IEFk
ZCB3YWtldXAgbWVjaGFuaXNtIGZvciBvbWFwLXVhcnRzKQpyZW1vdmVkIG1vZHVsZSBsZXZlbCB3
YWtldXAgZW5hYmxlL2Rpc2FibGUgbWVjaGFuaXNtIGFuZCByZXRhaW5lZCBvbmx5CnRoZSBwYWQg
d2FrZXVwIGhhbmRsaW5nLgoKT24gMjR4eC8zNHh4LzM2eHggTW9kdWxlIGxldmVsIHdha2V1cCBl
dmVudHMgYXJlIGVuYWJsZWQvZGlzYWJsZWQgdXNpbmcKUE1fV0tFTjFfQ09SRS9QTV9XS0VOX1BF
UiByZWdzLiBUaGUgbW9kdWxlIGxldmVsIHdha2V1cHMgYXJlIGVuYWJsZWQgYnkKZGVmYXVsdCBm
cm9tIGJvb3Rsb2FkZXIsIGhvd2V2ZXIgdGhlIHdha2V1cHMgY2FuIGJlIGVuYWJsZWQvZGlzYWJs
ZWQKdXNpbmcgc3lzZnMgZW50cnkKZWNobyBkaXNhYmxlZCA+IC9zeXMvZGV2aWNlcy9wbGF0Zm9y
bS9vbWFwL29tYXBfdWFydC5YL3Bvd2VyL3dha2V1cApbWD0wLDEsMiwzXQoKU2luY2UgbW9kdWxl
IGxldmVsIHdha2V1cHMgd2VyZSBsZWZ0IGVuYWJsZWQgZnJvbSBib290dXAgYW5kIHdoZW4Kd2Fr
ZXVwcyB3ZXJlIGRpc2FibGVkIGZyb20gc3lzZnMgdWFydCBtb2R1bGUgbGV2ZWwgd2FrZXVwcyB3
ZXJlCnN0aWxsIGhhcHBlbmluZyBhcyB0aGV5IHdlcmUgbm90IGdldHRpbmcgZGlzYWJsZWQuCgpB
ZGRpbmcgdGhlIHN1cHBvcnQgdG8gaGFuZGxlIG1vZHVsZSBsZXZlbCB3YWtldXBzIGZvciBvbWFw
Mi8zIHNvY3MuCgpTaWduZWQtb2ZmLWJ5OiBHb3ZpbmRyYWouUiA8Z292aW5kcmFqLnJhamFAdGku
Y29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvc2VyaWFsLmMgICAgICAgICAgICAgICAgICB8
ICAgODggKysrKysrKysrKysrKysrKysrKysrKysrLQogYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1
ZGUvcGxhdC9vbWFwLXNlcmlhbC5oIHwgICAgMyArLQogZHJpdmVycy90dHkvc2VyaWFsL29tYXAt
c2VyaWFsLmMgICAgICAgICAgICAgIHwgICAxNSArKystCiAzIGZpbGVzIGNoYW5nZWQsIDk5IGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1v
bWFwMi9zZXJpYWwuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvc2VyaWFsLmMKaW5kZXggMGNkZDM1
OS4uOTMxMmQ2YiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9zZXJpYWwuYworKysg
Yi9hcmNoL2FybS9tYWNoLW9tYXAyL3NlcmlhbC5jCkBAIC00MSw2ICs0MSw3IEBACiAjaW5jbHVk
ZSAicHJtLXJlZ2JpdHMtMzR4eC5oIgogI2luY2x1ZGUgImNvbnRyb2wuaCIKICNpbmNsdWRlICJt
dXguaCIKKyNpbmNsdWRlICJpb21hcC5oIgogCiAvKgogICogTk9URTogQnkgZGVmYXVsdCB0aGUg
c2VyaWFsIGF1dG9fc3VzcGVuZCB0aW1lb3V0IGlzIGRpc2FibGVkIGFzIGl0IGNhdXNlcwpAQCAt
NTUsNiArNTYsMTAgQEAKIHN0cnVjdCBvbWFwX3VhcnRfc3RhdGUgewogCWludCBudW07CiAKKwl2
b2lkIF9faW9tZW0gKndrX3N0OworCXZvaWQgX19pb21lbSAqd2tfZW47CisJdTMyIHdrX21hc2s7
CisKIAlzdHJ1Y3QgbGlzdF9oZWFkIG5vZGU7CiAJc3RydWN0IG9tYXBfaHdtb2QgKm9oOwogfTsK
QEAgLTgwLDE3ICs4NSw0NiBAQCBzdGF0aWMgc3RydWN0IG9tYXBfdWFydF9wb3J0X2luZm8gb21h
cF9zZXJpYWxfZGVmYXVsdF9pbmZvW10gX19pbml0ZGF0YSA9IHsKIH07CiAKICNpZmRlZiBDT05G
SUdfUE0KKworc3RhdGljIHZvaWQgb21hcF91YXJ0X2Rpc2FibGVfbW9kdWxlX3dha2V1cChzdHJ1
Y3Qgb21hcF91YXJ0X3N0YXRlICp1YXJ0KQoreworCS8qIENsZWFyIHdha2UtZW5hYmxlIGJpdCAq
LworCWlmICh1YXJ0LT53a19lbiAmJiB1YXJ0LT53a19tYXNrKSB7CisJCXUzMiB2ID0gX19yYXdf
cmVhZGwodWFydC0+d2tfZW4pOworCQl2ICY9IH51YXJ0LT53a19tYXNrOworCQlfX3Jhd193cml0
ZWwodiwgdWFydC0+d2tfZW4pOworCX0KK30KKworc3RhdGljIHZvaWQgb21hcF91YXJ0X2VuYWJs
ZV9tb2R1bGVfd2FrZXVwKHN0cnVjdCBvbWFwX3VhcnRfc3RhdGUgKnVhcnQpCit7CisJLyogU2V0
IHdha2UtZW5hYmxlIGJpdCAqLworCWlmICh1YXJ0LT53a19lbiAmJiB1YXJ0LT53a19tYXNrKSB7
CisJCXUzMiB2ID0gX19yYXdfcmVhZGwodWFydC0+d2tfZW4pOworCQl2IHw9IHVhcnQtPndrX21h
c2s7CisJCV9fcmF3X3dyaXRlbCh2LCB1YXJ0LT53a19lbik7CisJfQorfQorCiBzdGF0aWMgdm9p
ZCBvbWFwX3VhcnRfZW5hYmxlX3dha2V1cChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBi
b29sIGVuYWJsZSkKIHsKIAlzdHJ1Y3Qgb21hcF9kZXZpY2UgKm9kID0gdG9fb21hcF9kZXZpY2Uo
cGRldik7CisJc3RydWN0IG9tYXBfdWFydF9zdGF0ZSAqdWFydDsKIAogCWlmICghb2QpCiAJCXJl
dHVybjsKIAotCWlmIChlbmFibGUpCisJbGlzdF9mb3JfZWFjaF9lbnRyeSh1YXJ0LCAmdWFydF9s
aXN0LCBub2RlKQorCQlpZiAocGRldi0+aWQgPT0gdWFydC0+bnVtKQorCQkJYnJlYWs7CisKKwlp
ZiAoZW5hYmxlKSB7CisJCW9tYXBfdWFydF9lbmFibGVfbW9kdWxlX3dha2V1cCh1YXJ0KTsKIAkJ
b21hcF9od21vZF9lbmFibGVfd2FrZXVwKG9kLT5od21vZHNbMF0pOwotCWVsc2UKKwl9IGVsc2Ug
eworCQlvbWFwX3VhcnRfZGlzYWJsZV9tb2R1bGVfd2FrZXVwKHVhcnQpOwogCQlvbWFwX2h3bW9k
X2Rpc2FibGVfd2FrZXVwKG9kLT5od21vZHNbMF0pOworCX0KIH0KIAogLyoKQEAgLTExMiw3ICsx
NDYsNTYgQEAgc3RhdGljIHZvaWQgb21hcF91YXJ0X3NldF9zbWFydGlkbGUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKIAlvbWFwX2h3bW9kX3NldF9zbGF2ZV9pZGxlbW9kZShvZC0+aHdt
b2RzWzBdLCBIV01PRF9JRExFTU9ERV9TTUFSVCk7CiB9CiAKK3N0YXRpYyB2b2lkIG9tYXBfdWFy
dF9pZGxlX2luaXQoc3RydWN0IG9tYXBfdWFydF9zdGF0ZSAqdWFydCkKK3sKKwlpZiAoY3B1X2lz
X29tYXAzNHh4KCkgJiYgIWNwdV9pc190aTgxNngoKSkgeworCQl1MzIgbW9kID0gKHVhcnQtPm51
bSA9PSAyKSA/IE9NQVAzNDMwX1BFUl9NT0QgOiBDT1JFX01PRDsKKworCQl1YXJ0LT53a19lbiA9
IE9NQVAzNFhYX1BSTV9SRUdBRERSKG1vZCwgUE1fV0tFTjEpOworCQl1YXJ0LT53a19zdCA9IE9N
QVAzNFhYX1BSTV9SRUdBRERSKG1vZCwgUE1fV0tTVDEpOworCQlzd2l0Y2ggKHVhcnQtPm51bSkg
eworCQljYXNlIDA6CisJCQl1YXJ0LT53a19tYXNrID0gT01BUDM0MzBfU1RfVUFSVDFfTUFTSzsK
KwkJCWJyZWFrOworCQljYXNlIDE6CisJCQl1YXJ0LT53a19tYXNrID0gT01BUDM0MzBfU1RfVUFS
VDJfTUFTSzsKKwkJCWJyZWFrOworCQljYXNlIDI6CisJCQl1YXJ0LT53a19tYXNrID0gT01BUDM0
MzBfU1RfVUFSVDNfTUFTSzsKKwkJCWJyZWFrOworCQljYXNlIDM6CisJCQl1YXJ0LT53a19tYXNr
ID0gT01BUDM2MzBfU1RfVUFSVDRfTUFTSzsKKwkJCWJyZWFrOworCQl9CisJfSBlbHNlIGlmIChj
cHVfaXNfb21hcDI0eHgoKSkgeworCisJCWlmIChjcHVfaXNfb21hcDI0MzAoKSkgeworCQkJdWFy
dC0+d2tfZW4gPSBPTUFQMjQzMF9QUk1fUkVHQUREUihDT1JFX01PRCwgUE1fV0tFTjEpOworCQkJ
dWFydC0+d2tfc3QgPSBPTUFQMjQzMF9QUk1fUkVHQUREUihDT1JFX01PRCwgUE1fV0tTVDEpOwor
CQl9IGVsc2UgaWYgKGNwdV9pc19vbWFwMjQyMCgpKSB7CisJCQl1YXJ0LT53a19lbiA9IE9NQVAy
NDIwX1BSTV9SRUdBRERSKENPUkVfTU9ELCBQTV9XS0VOMSk7CisJCQl1YXJ0LT53a19zdCA9IE9N
QVAyNDIwX1BSTV9SRUdBRERSKENPUkVfTU9ELCBQTV9XS1NUMSk7CisJCX0KKwkJc3dpdGNoICh1
YXJ0LT5udW0pIHsKKwkJY2FzZSAwOgorCQkJdWFydC0+d2tfbWFzayA9IE9NQVAyNFhYX1NUX1VB
UlQxX01BU0s7CisJCQlicmVhazsKKwkJY2FzZSAxOgorCQkJdWFydC0+d2tfbWFzayA9IE9NQVAy
NFhYX1NUX1VBUlQyX01BU0s7CisJCQlicmVhazsKKwkJY2FzZSAyOgorCQkJdWFydC0+d2tfbWFz
ayA9IE9NQVAyNFhYX1NUX1VBUlQzX01BU0s7CisJCQlicmVhazsKKwkJfQorCX0gZWxzZSB7CisJ
CXVhcnQtPndrX2VuID0gMDsKKwkJdWFydC0+d2tfc3QgPSAwOworCQl1YXJ0LT53a19tYXNrID0g
MDsKKwl9Cit9CisKICNlbHNlCitzdGF0aWMgdm9pZCBvbWFwX3VhcnRfaWRsZV9pbml0KHN0cnVj
dCBvbWFwX3VhcnRfc3RhdGUgKnVhcnQpIHt9CiBzdGF0aWMgdm9pZCBvbWFwX3VhcnRfZW5hYmxl
X3dha2V1cChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBib29sIGVuYWJsZSkKIHt9CiBz
dGF0aWMgdm9pZCBvbWFwX3VhcnRfc2V0X25vaWRsZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KSB7fQpAQCAtMzQzLDYgKzQyNiw3IEBAIHZvaWQgX19pbml0IG9tYXBfc2VyaWFsX2luaXRf
cG9ydChzdHJ1Y3Qgb21hcF9ib2FyZF9kYXRhICpiZGF0YSwKIAlvaCA9IHVhcnQtPm9oOwogCW5h
bWUgPSBEUklWRVJfTkFNRTsKIAorCW9tYXBfdWFydF9pZGxlX2luaXQodWFydCk7CiAJb21hcF91
cC5kbWFfZW5hYmxlZCA9IGluZm8tPmRtYV9lbmFibGVkOwogCW9tYXBfdXAudWFydGNsayA9IE9N
QVAyNFhYX0JBU0VfQkFVRCAqIDE2OwogCW9tYXBfdXAuZmxhZ3MgPSBVUEZfQk9PVF9BVVRPQ09O
RjsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvb21hcC1zZXJp
YWwuaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvb21hcC1zZXJpYWwuaAppbmRl
eCA5ZmY0NDQ0Li4zODZhMjViIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVk
ZS9wbGF0L29tYXAtc2VyaWFsLmgKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxh
dC9vbWFwLXNlcmlhbC5oCkBAIC0xMzAsNyArMTMwLDggQEAgc3RydWN0IHVhcnRfb21hcF9wb3J0
IHsKIAl1bnNpZ25lZCBsb25nCQlwb3J0X2FjdGl2aXR5OwogCXUzMgkJCWNvbnRleHRfbG9zc19j
bnQ7CiAJdTMyCQkJZXJyYXRhOwotCXU4CQkJd2FrZXVwc19lbmFibGVkOworCXU4CQkJcGFkX3dh
a2V1cHNfZW5hYmxlZDsKKwl1OAkJCW1vZHVsZV93YWtldXBzX2VuYWJsZWQ7CiAKIAlzdHJ1Y3Qg
cG1fcW9zX3JlcXVlc3QJcG1fcW9zX3JlcXVlc3Q7CiAJdTMyCQkJbGF0ZW5jeTsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jIGIvZHJpdmVycy90dHkvc2VyaWFs
L29tYXAtc2VyaWFsLmMKaW5kZXggMDEyMTQ4Ni4uYmIwYTc0ZCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy90dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL29tYXAt
c2VyaWFsLmMKQEAgLTE0NTgsNiArMTQ1OCwxMSBAQCBzdGF0aWMgaW50IHNlcmlhbF9vbWFwX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCXVwLT51YXJ0X2RtYS5yeF9kbWFf
Y2hhbm5lbCA9IE9NQVBfVUFSVF9ETUFfQ0hfRlJFRTsKIAl9CiAKKwkvKiBNb2R1bGUgbGV2ZWwg
d2FrZXVwIHdpbGwgYmUgbGVmdCBlbmFibGVkCisJICogZnJvbSBib290bG9hZGVyLgorCSAqLwor
CXVwLT5tb2R1bGVfd2FrZXVwc19lbmFibGVkID0gdHJ1ZTsKKwogCXVwLT5sYXRlbmN5ID0gUE1f
UU9TX0NQVV9ETUFfTEFUX0RFRkFVTFRfVkFMVUU7CiAJdXAtPmNhbGNfbGF0ZW5jeSA9IFBNX1FP
U19DUFVfRE1BX0xBVF9ERUZBVUxUX1ZBTFVFOwogCXBtX3Fvc19hZGRfcmVxdWVzdCgmdXAtPnBt
X3Fvc19yZXF1ZXN0LApAQCAtMTU4NiwxNCArMTU5MSwxNiBAQCBzdGF0aWMgaW50IHNlcmlhbF9v
bWFwX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJCXVwLT5jb250ZXh0X2xv
c3NfY250ID0gcGRhdGEtPmdldF9jb250ZXh0X2xvc3NfY291bnQoZGV2KTsKIAogCWlmIChkZXZp
Y2VfbWF5X3dha2V1cChkZXYpKSB7Ci0JCWlmICghdXAtPndha2V1cHNfZW5hYmxlZCkgeworCQlp
ZiAoIXVwLT5wYWRfd2FrZXVwc19lbmFibGVkIHx8ICF1cC0+bW9kdWxlX3dha2V1cHNfZW5hYmxl
ZCkgewogCQkJcGRhdGEtPmVuYWJsZV93YWtldXAodXAtPnBkZXYsIHRydWUpOwotCQkJdXAtPndh
a2V1cHNfZW5hYmxlZCA9IHRydWU7CisJCQl1cC0+bW9kdWxlX3dha2V1cHNfZW5hYmxlZCA9IHRy
dWU7CisJCQl1cC0+cGFkX3dha2V1cHNfZW5hYmxlZCA9IHRydWU7CiAJCX0KIAl9IGVsc2Ugewot
CQlpZiAodXAtPndha2V1cHNfZW5hYmxlZCkgeworCQlpZiAodXAtPnBhZF93YWtldXBzX2VuYWJs
ZWQgfHwgdXAtPm1vZHVsZV93YWtldXBzX2VuYWJsZWQpIHsKIAkJCXBkYXRhLT5lbmFibGVfd2Fr
ZXVwKHVwLT5wZGV2LCBmYWxzZSk7Ci0JCQl1cC0+d2FrZXVwc19lbmFibGVkID0gZmFsc2U7CisJ
CQl1cC0+bW9kdWxlX3dha2V1cHNfZW5hYmxlZCA9IGZhbHNlOworCQkJdXAtPnBhZF93YWtldXBz
X2VuYWJsZWQgPSBmYWxzZTsKIAkJfQogCX0KIAotLSAKMS43LjUuNAoK
--14dae93993d19be1d704bc71e228--
