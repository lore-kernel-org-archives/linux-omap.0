From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix omap1510-generic board compilation.
Date: Sun, 10 Jun 2007 13:52:57 +0200
Message-ID: <fb249edb0706100452i479dcfft3ba050dfade880ff@mail.gmail.com>
References: <fb249edb0706061945n20d12010scf13154d981c0657@mail.gmail.com>
	<20070608103126.GM28556@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_61020_14016347.1181476377830"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070608103126.GM28556@atomide.com>
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
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_61020_14016347.1181476377830
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 08/06/07, Tony Lindgren <tony@atomide.com> wrote:
> * andrzej zaborowski <balrogg@gmail.com> [070606 19:46]:
> > Move an #endif so that it doesn't hide the mmc config declaration.
> > Minor formatting change.
> >
> > Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
>
[...]
> This one does not seem to apply, did you forget to send your patch
> 0006 that this depends on?

Sorry, forgot to update my tree before diffing. Attached is a version
that applies. Sorry for the noise.

0006 was the collective defconfig update which doesn't seem to have
made it to everyone's mailboxes because it was 200+ KB. Will resend
the update separated per board.

Cheers,
Andrzej

------=_Part_61020_14016347.1181476377830
Content-Type: text/plain;
	name=0015-ARM-OMAP-Fix-omap1510-generic-board-compilation.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2rih86q
Content-Disposition: attachment;
	filename="0015-ARM-OMAP-Fix-omap1510-generic-board-compilation.txt"

RnJvbSA1YTUxZDlkMzQ4MGQ5ZDZiMWVmZTRlNmRiZjljMWVmYzc1ZDc1Y2FkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGJhbHJvZ0B6YWJvci5vcmc+
CkRhdGU6IFN1biwgMTAgSnVuIDIwMDcgMTQ6MzY6MzQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBB
Uk06IE9NQVA6IEZpeCBvbWFwMTUxMC1nZW5lcmljIGJvYXJkIGNvbXBpbGF0aW9uCgpNb3ZlIGFu
ICNlbmRpZiBzbyB0aGF0IGl0IGRvZXNuJ3QgaGlkZSB0aGUgbW1jIGNvbmZpZyBkZWNsYXJhdGlv
bi4KTWlub3IgZm9ybWF0dGluZyBjaGFuZ2UuCi0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2Fy
ZC1nZW5lcmljLmMgfCAgICA3ICsrKy0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDEvYm9h
cmQtZ2VuZXJpYy5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2FyZC1nZW5lcmljLmMKaW5kZXgg
MjI4ZmQwMC4uNGIzNWYxNiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2FyZC1n
ZW5lcmljLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2FyZC1nZW5lcmljLmMKQEAgLTU1
LDYgKzU1LDcgQEAgc3RhdGljIHN0cnVjdCBvbWFwX3VzYl9jb25maWcgZ2VuZXJpYzE2MTBfdXNi
X2NvbmZpZyBfX2luaXRkYXRhID0gewogCS5obWNfbW9kZQk9IDE2LAogCS5waW5zWzBdCT0gNiwK
IH07CisjZW5kaWYKIAogc3RhdGljIHN0cnVjdCBvbWFwX21tY19jb25maWcgZ2VuZXJpY19tbWNf
Y29uZmlnIF9faW5pdGRhdGEgPSB7CiAJLm1tYyBbMF0gPSB7CkBAIC03MywxNSArNzQsMTMgQEAg
c3RhdGljIHN0cnVjdCBvbWFwX21tY19jb25maWcgZ2VuZXJpY19tbWNfY29uZmlnIF9faW5pdGRh
dGEgPSB7CiAJfSwKIH07CiAKLSNlbmRpZgotCiBzdGF0aWMgc3RydWN0IG9tYXBfdWFydF9jb25m
aWcgZ2VuZXJpY191YXJ0X2NvbmZpZyBfX2luaXRkYXRhID0gewogCS5lbmFibGVkX3VhcnRzID0g
KCgxIDw8IDApIHwgKDEgPDwgMSkgfCAoMSA8PCAyKSksCiB9OwogCiBzdGF0aWMgc3RydWN0IG9t
YXBfYm9hcmRfY29uZmlnX2tlcm5lbCBnZW5lcmljX2NvbmZpZ1tdIF9faW5pdGRhdGEgPSB7Ci0J
eyBPTUFQX1RBR19VU0IsICAgICAgICAgICBOVUxMIH0sCi0JeyBPTUFQX1RBR19NTUMsICAgICAg
ICAgICAmZ2VuZXJpY19tbWNfY29uZmlnIH0sCisJeyBPTUFQX1RBR19VU0IsCQlOVUxMIH0sCisJ
eyBPTUFQX1RBR19NTUMsCQkmZ2VuZXJpY19tbWNfY29uZmlnIH0sCiAJeyBPTUFQX1RBR19VQVJU
LAkmZ2VuZXJpY191YXJ0X2NvbmZpZyB9LAogfTsKIAotLSAKMS40LjQuMwoK
------=_Part_61020_14016347.1181476377830
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_61020_14016347.1181476377830--
