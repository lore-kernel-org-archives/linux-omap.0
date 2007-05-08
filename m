From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Git tree updated
Date: Tue, 8 May 2007 17:35:41 +0530
Message-ID: <5d5443650705080505j1a8beb98q279db065fdf9366c@mail.gmail.com>
References: <20070508031945.GH31968@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_101653_29873214.1178625941475"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070508031945.GH31968@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

------=_Part_101653_29873214.1178625941475
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Tony,

On 5/8/07, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> I've updated our git tree to be in sync with mainline tree as Russell
> has merged some of our pending patches.
>
> Looks like 24xx does not currently boot, it seems to hang at
> devicemaps_init(). I've verified that at least 16xx boots.
>
> I'll have to continue debugging the 24xx devicemaps_init issue tomorrow,
> if somebody gets it working before that, please post the patch :)
>

arch/arm/mach-omap2/io.c seems have some duplication due to merging
problem it seems.
I have attached patch to remove those entries.

-- 
--Trilok Soni

------=_Part_101653_29873214.1178625941475
Content-Type: text/x-patch;
	name=0001-ARM-OMAP-Remove-duplicate-entries-from-omap2-io.c.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1gbf0rg
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Remove-duplicate-entries-from-omap2-io.c.patch"

RnJvbSA4MGIyYjQ3ZDM3M2M4NDA5MDNlOGM0ZGZhNjhiMTQ4NWNkNDkwYzgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcmlsb2sgU29uaSA8c29uaS50cmlsb2tAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDggTWF5IDIwMDcgMjM6MDU6MjUgKzA1MzAKU3ViamVjdDogW1BBVENIXSBBUk06
IE9NQVA6IFJlbW92ZSBkdXBsaWNhdGUgZW50cmllcyBmcm9tIG9tYXAyIGlvLmMKCi0gUmVtb3Zl
IGR1cGxpY2F0ZSBlbnRyaWVzIGdlbmVyYXRlZCBkdWUgdG8gbWVyZ2luZy4KClNpZ25lZC1vZmYt
Ynk6IFRyaWxvayBTb25pIDxzb25pLnRyaWxva0BnbWFpbC5jb20+Ci0tLQogYXJjaC9hcm0vbWFj
aC1vbWFwMi9pby5jIHwgICA0NCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDQ0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvaW8uYyBiL2FyY2gvYXJtL21hY2gt
b21hcDIvaW8uYwppbmRleCBhODhiZDFlLi5mYmEyZTg2IDEwMDY0NAotLS0gYS9hcmNoL2FybS9t
YWNoLW9tYXAyL2lvLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9pby5jCkBAIC04OCw1MCAr
ODgsNiBAQCBzdGF0aWMgc3RydWN0IG1hcF9kZXNjIG9tYXAyX2lvX2Rlc2NbXSBfX2luaXRkYXRh
ID0gewogCQkubGVuZ3RoCQk9IERTUF9NTVVfMjRYWF9TSVpFLAogCQkudHlwZQkJPSBNVF9ERVZJ
Q0UKIAl9LAotI2lmZGVmIENPTkZJR19BUkNIX09NQVAyNDMwCi0JewotCQkudmlydHVhbAk9IEw0
X1dLXzI0M1hfVklSVCwKLQkJLnBmbgkJPSBfX3BoeXNfdG9fcGZuKEw0X1dLXzI0M1hfUEhZUyks
Ci0JCS5sZW5ndGgJCT0gTDRfV0tfMjQzWF9TSVpFLAotCQkudHlwZQkJPSBNVF9ERVZJQ0UKLQl9
LAotCXsKLQkJLnZpcnR1YWwJPSBPTUFQMjQzWF9HUE1DX1ZJUlQsCi0JCS5wZm4JCT0gX19waHlz
X3RvX3BmbihPTUFQMjQzWF9HUE1DX1BIWVMpLAotCQkubGVuZ3RoCQk9IE9NQVAyNDNYX0dQTUNf
U0laRSwKLQkJLnR5cGUJCT0gTVRfREVWSUNFCi0JfSwKLQl7Ci0JCS52aXJ0dWFsCT0gT01BUDI0
M1hfU0RSQ19WSVJULAotCQkucGZuCQk9IF9fcGh5c190b19wZm4oT01BUDI0M1hfU0RSQ19QSFlT
KSwKLQkJLmxlbmd0aAkJPSBPTUFQMjQzWF9TRFJDX1NJWkUsCi0JCS50eXBlCQk9IE1UX0RFVklD
RQotCX0sCi0JewotCQkudmlydHVhbAk9IE9NQVAyNDNYX1NNU19WSVJULAotCQkucGZuCQk9IF9f
cGh5c190b19wZm4oT01BUDI0M1hfU01TX1BIWVMpLAotCQkubGVuZ3RoCQk9IE9NQVAyNDNYX1NN
U19TSVpFLAotCQkudHlwZQkJPSBNVF9ERVZJQ0UKLQl9LAotI2VuZGlmCi0JewotCQkudmlydHVh
bAk9IERTUF9NRU1fMjRYWF9WSVJULAotCQkucGZuCQk9IF9fcGh5c190b19wZm4oRFNQX01FTV8y
NFhYX1BIWVMpLAotCQkubGVuZ3RoCQk9IERTUF9NRU1fMjRYWF9TSVpFLAotCQkudHlwZQkJPSBN
VF9ERVZJQ0UKLQl9LAotCXsKLQkJLnZpcnR1YWwJPSBEU1BfSVBJXzI0WFhfVklSVCwKLQkJLnBm
bgkJPSBfX3BoeXNfdG9fcGZuKERTUF9JUElfMjRYWF9QSFlTKSwKLQkJLmxlbmd0aAkJPSBEU1Bf
SVBJXzI0WFhfU0laRSwKLQkJLnR5cGUJCT0gTVRfREVWSUNFCi0JfSwKLQl7Ci0JCS52aXJ0dWFs
CT0gRFNQX01NVV8yNFhYX1ZJUlQsCi0JCS5wZm4JCT0gX19waHlzX3RvX3BmbihEU1BfTU1VXzI0
WFhfUEhZUyksCi0JCS5sZW5ndGgJCT0gRFNQX01NVV8yNFhYX1NJWkUsCi0JCS50eXBlCQk9IE1U
X0RFVklDRQotCX0KIH07CiAKIHZvaWQgX19pbml0IG9tYXAyX21hcF9jb21tb25faW8odm9pZCkK
LS0gCjEuNS4wCgo=
------=_Part_101653_29873214.1178625941475
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_101653_29873214.1178625941475--
