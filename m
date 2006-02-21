From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Make H2 board file compile without irda warning
Date: Tue, 21 Feb 2006 13:54:26 -0800 (PST)
Message-ID: <20060221215426.68231.qmail@web32903.mail.mud.yahoo.com>
References: <20060221212838.67357.qmail@web32905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1647374327-1140558866=:65541"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060221212838.67357.qmail@web32905.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--0-1647374327-1140558866=:65541
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Komal Shah <komal_shah802003@yahoo.com> wrote:

> 
> True, the warning will be generated, but I added that check
> considering
> that transceiver_mode function will be active only if we are
> successfully able to request that GPIO. So, I am _not_ sure, but it
> is
> better to #ifdef around the h2_transceiver_mode(...) function. What
> do
> you think?
> 

And here comes the patch.

OMAP: Irda: Remove warning
arch/arm/mach-omap1/board-h2.c:244: warning: 'h2_transceiver_mode'
defined but not used.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1647374327-1140558866=:65541
Content-Type: application/octet-stream; name="h2Irda.patch"
Content-Transfer-Encoding: base64
Content-Description: 390387012-h2Irda.patch
Content-Disposition: attachment; filename="h2Irda.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDEvYm9hcmQtaDIuYyBi
L2FyY2gvYXJtL21hY2gtb21hcDEvYm9hcmQtaDIuYwppbmRleCA2ODBlNjdl
Li5jYmM3Njc0IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAxL2Jv
YXJkLWgyLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2FyZC1oMi5j
CkBAIC0yNDAsNiArMjQwLDcgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgaDJfa3BfZGV2aQogCiAjZGVmaW5lIEgyX0lSREFfRklSU0VMX0dQ
SU9fUElOCTE3CiAKKyNpZiBkZWZpbmVkKENPTkZJR19PTUFQX0lSKSB8fCBk
ZWZpbmVkKENPTkZJR19PTUFQX0lSX01PRFVMRSkgCiBzdGF0aWMgaW50IGgy
X3RyYW5zY2VpdmVyX21vZGUoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgc3Rh
dGUpCiB7CiAJaWYgKHN0YXRlICYgSVJfU0lSTU9ERSkKQEAgLTI0OSw2ICsy
NTAsNyBAQCBzdGF0aWMgaW50IGgyX3RyYW5zY2VpdmVyX21vZGUoc3RydWN0
IGRlCiAKIAlyZXR1cm4gMDsKIH0KKyNlbmRpZgogCiBzdGF0aWMgc3RydWN0
IG9tYXBfaXJkYV9jb25maWcgaDJfaXJkYV9kYXRhID0gewogCS50cmFuc2Nl
aXZlcl9jYXAJPSBJUl9TSVJNT0RFIHwgSVJfTUlSTU9ERSB8IElSX0ZJUk1P
REUsCg==

--0-1647374327-1140558866=:65541
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1647374327-1140558866=:65541--
