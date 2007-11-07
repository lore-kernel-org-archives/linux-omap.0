From: "=?UTF-8?Q?Lu=C3=ADs_Cargnini?=" <lvcargnini@gmail.com>
Subject: problems during copy_to_user
Date: Wed, 7 Nov 2007 20:46:44 -0200
Message-ID: <ae36f8040711071446kb68c1d1k47511ab565b9747a@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1473806653=="
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--===============1473806653==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

RGVhciBGZWxsb3dzLAoKSSdtIGRvaW5nIHRoZSBmb2xsb3dpbmc6CiAgICBsaWRvID0gb21hcF9t
Y2JzcF9yZWN2X3dvcmQoZGV2LT5hZGNfZGV2KTsKICAgICBpID0gY29weV90b191c2VyKGJ1Ziwg
JmxpZG8sIGNvdW50KTsKCmJ1dCBpdCBpcyBkZW1vbnN0cmF0aW5nIHRoYXQsIEkgY2Fubm90IHRy
YW5zbWl0IHRvIHVzZXItc3BhY2Ugb3IgSSBoYXZpbmcKcHJvYmxlbXMgaW4gdGhpcyBvcGVyYXRp
b24sCkkgZG9uJ3Qga25vdyB3aHkuIFVzZXItU3BhY2Ugc3cgaXMgZG9pbmcgdGhlIGZvbGxvd2lu
ZzoKX2RhZG9zID0gcmVhZChmZCwgbGUsIHNpemVvZihfX3UzMikpOwpsaWRvIGlzIG9mIHNpemUg
dTMyOwpDb3VsZCBiZSB0aGlzIHRoZSBwcm9ibGVtID8KCkkgdGVzdCB3aXRoIHNwaW5fbG9ja3Mg
YW5kIHdpdGhvdXQgc3Bpbl9sb2NrcyB0aGUgZXJyb3IgcmVtYWluIHRoZSBzYW1lLgoKZS5nLjog
d2l0aCBzcGluX2xvY2tzIGFzIHJlY29tbWVuZGVkIGluIExERHYzIGZvciBleGFtcGxlLgoKc3Bp
bl9sb2NrX2lycSgmZGV2LT5zbG9jayk7CmxpZG8gPSBvbWFwX21jYnNwX3JlY3Zfd29yZChkZXYt
PmFkY19kZXYpOwogICAgIGkgPSBjb3B5X3RvX3VzZXIoYnVmLCAmbGlkbywgY291bnQpOwpzcGlu
X3VubG9ja19pcnEoJmRldi0+c2xvY2spOwoKCgotLSAKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRo
YW5rcyAmJiBSZWdhcmRzCk1zYy4gQnNjLiBMdcOtcyBWaXTDs3JpbyBDYXJnbmluaQpJRUVFIE1l
bWJlcgpFbGVjdHJpY2FsIEVuZ2luZWVyIEZhY3VsdHkgQCBQVUNSUwpJcGlyYW5nYSBBdmVudWUs
IDY2ODEg4oCTIEJ1aWxkaW5nIDMwClAuTy4gQm94OiA5MDYxOS05MDAg4oCTIFBvcnRvIEFsZWdy
ZS9SUwpQaG9uZTogKzU1IDUxIDMzMjAgMzUwMCAgZXh0ZW5zaW9uOiA3Njk2Ci0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQo=
--===============1473806653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1473806653==--
