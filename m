From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: Re: [PATCH] Make H2 board file compile without irda warning
Date: Wed, 22 Feb 2006 09:40:33 -0400
Message-ID: <9268368b0602220540n1cfd8a14oc83d805823821eb0@mail.gmail.com>
References: <20060221212838.67357.qmail@web32905.mail.mud.yahoo.com>
	<20060221215426.68231.qmail@web32903.mail.mud.yahoo.com>
	<9268368b0602220518r20ea5269k36432777acbf75b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5745_20473236.1140615633528"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602220518r20ea5269k36432777acbf75b2@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_5745_20473236.1140615633528
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ops, here goes the proper patch:

On 2/22/06, Daniel Petrini <d.pensator@gmail.com> wrote:
> Hi,
>
> On 2/21/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> > --- Komal Shah <komal_shah802003@yahoo.com> wrote:
> >
> > >
> > > True, the warning will be generated, but I added that check
> > > considering
> > > that transceiver_mode function will be active only if we are
> > > successfully able to request that GPIO. So, I am _not_ sure, but it
> > > is
> > > better to #ifdef around the h2_transceiver_mode(...) function. What
> > > do
> > > you think?
> > >
> >
> > And here comes the patch.
> >
> > OMAP: Irda: Remove warning
> > arch/arm/mach-omap1/board-h2.c:244: warning: 'h2_transceiver_mode'
> > defined but not used.
> >
> > Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
> >
> > ---Komal Shah
> > http://komalshah.blogspot.com/
>

 Humm, my first idea was exactly like this but I tried to avoid another #if=
def..
 So what about this new approach, which still avoids #ifdefs although
 with expense of one flag ?

 --

The board file for H2 is generating a warning if compiled without
InfraRed selection.

This patch changes the location where the function h2_transceiver_mode
is assigned to structure h2_irda_data, thereby preventing the warning
and also creates a flag variable telling when is safe to use h2
platform function for IR.

Signed-off-by Daniel Petrini <d.pensator_at_gmail.com>

Daniel
--
INdT - Manaus - Brazil

------=_Part_5745_20473236.1140615633528
Content-Type: text/x-patch; name="h2-irda-compile.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="h2-irda-compile.patch"
X-Attachment-Id: f_ejzoz3e1

SW5kZXg6IGxpbnV4LW9tYXAtMi42LmdpdC1xL2FyY2gvYXJtL21hY2gtb21hcDEvYm9hcmQtaDIu
Ywo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSBsaW51eC1vbWFwLTIuNi5naXQtcS5vcmlnL2FyY2gvYXJtL21hY2gt
b21hcDEvYm9hcmQtaDIuYwkyMDA2LTAyLTIxIDEwOjExOjAxLjAwMDAwMDAwMCAtMDQwMAorKysg
bGludXgtb21hcC0yLjYuZ2l0LXEvYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2FyZC1oMi5jCTIwMDYt
MDItMjIgMDg6NTQ6MTYuMDAwMDAwMDAwIC0wNDAwCkBAIC0yNTIsNiArMjUyLDggQEAgc3RhdGlj
IGludCBoMl90cmFuc2NlaXZlcl9tb2RlKHN0cnVjdCBkZQogCiBzdGF0aWMgc3RydWN0IG9tYXBf
aXJkYV9jb25maWcgaDJfaXJkYV9kYXRhID0gewogCS50cmFuc2NlaXZlcl9jYXAJPSBJUl9TSVJN
T0RFIHwgSVJfTUlSTU9ERSB8IElSX0ZJUk1PREUsCisJLnRyYW5zY2VpdmVyX21vZGUJPSBoMl90
cmFuc2NlaXZlcl9tb2RlLAorCS5pcmRhX2NhcGFibGUJCT0gMCwKIH07CiAKIHN0YXRpYyBzdHJ1
Y3QgcmVzb3VyY2UgaDJfaXJkYV9yZXNvdXJjZXNbXSA9IHsKQEAgLTM3OSw3ICszODEsNyBAQCBz
dGF0aWMgdm9pZCBfX2luaXQgaDJfaW5pdCh2b2lkKQogCW9tYXBfd3JpdGVsKG9tYXBfcmVhZGwo
RlVOQ19NVVhfQ1RSTF9BKSB8IDcsIEZVTkNfTVVYX0NUUkxfQSk7CiAJaWYgKCEob21hcF9yZXF1
ZXN0X2dwaW8oSDJfSVJEQV9GSVJTRUxfR1BJT19QSU4pKSkgewogCQlvbWFwX3NldF9ncGlvX2Rp
cmVjdGlvbihIMl9JUkRBX0ZJUlNFTF9HUElPX1BJTiwgMCk7Ci0JCWgyX2lyZGFfZGF0YS50cmFu
c2NlaXZlcl9tb2RlID0gaDJfdHJhbnNjZWl2ZXJfbW9kZTsKKwkJaDJfaXJkYV9kYXRhLmlyZGFf
Y2FwYWJsZSA9IDE7CiAJfQogI2VuZGlmCiAKSW5kZXg6IGxpbnV4LW9tYXAtMi42LmdpdC1xL2lu
Y2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvaXJkYS5oCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LW9tYXAt
Mi42LmdpdC1xLm9yaWcvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9pcmRhLmgJMjAwNi0wMi0y
MiAwOTowMDozMC4wMDAwMDAwMDAgLTA0MDAKKysrIGxpbnV4LW9tYXAtMi42LmdpdC1xL2luY2x1
ZGUvYXNtLWFybS9hcmNoLW9tYXAvaXJkYS5oCTIwMDYtMDItMjIgMDk6MDE6MDIuMDAwMDAwMDAw
IC0wNDAwCkBAIC0yNSw2ICsyNSw4IEBAIHN0cnVjdCBvbWFwX2lyZGFfY29uZmlnIHsKIAkgKiBo
YXZpbmcgY2FsbHMgd2hpY2ggY2FuIHNsZWVwIGluIGlyZGFfc2V0X3NwZWVkLgogCSAqLwogCXN0
cnVjdCB3b3JrX3N0cnVjdCBncGlvX2V4cGE7CisJLyogVmVyeSBzcGVjaWZpYyB0byBIMiAtIHN1
Y2Nlc3MgaW4gb2J0YWluIGdwaW8gKi8KKwlpbnQgaXJkYV9jYXBhYmxlOwogfTsKIAogI2VuZGlm
CkluZGV4OiBsaW51eC1vbWFwLTIuNi5naXQtcS9kcml2ZXJzL25ldC9pcmRhL29tYXAtaXIuYwo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC1vbWFwLTIuNi5naXQtcS5vcmlnL2RyaXZlcnMvbmV0L2lyZGEv
b21hcC1pci5jCTIwMDYtMDItMTQgMDg6MjQ6NTQuMDAwMDAwMDAwIC0wNDAwCisrKyBsaW51eC1v
bWFwLTIuNi5naXQtcS9kcml2ZXJzL25ldC9pcmRhL29tYXAtaXIuYwkyMDA2LTAyLTIyIDA5OjAy
OjI3LjAwMDAwMDAwMCAtMDQwMApAQCAtMzM2LDcgKzMzNiw3IEBAIHN0YXRpYyBpbnQgb21hcF9p
cmRhX3N0YXJ0dXAoc3RydWN0IG5ldF8KIAogCS8qIE9ubHkgZm9yIEgyPwogCSAqLwotCWlmIChz
aS0+cGRhdGEtPnRyYW5zY2VpdmVyX21vZGUgJiYgbWFjaGluZV9pc19vbWFwX2gyKCkpIHsKKwlp
ZiAoc2ktPnBkYXRhLT5pcmRhX2NhcGFibGUgJiYgbWFjaGluZV9pc19vbWFwX2gyKCkpIHsKIAkg
ICAgCS8qIElzIGl0IHNlbGVjdF9pcmRhIG9uIEgyID8gKi8KIAkJb21hcF93cml0ZWwob21hcF9y
ZWFkbChGVU5DX01VWF9DVFJMX0EpIHwgNywKIAkgRlVOQ19NVVhfQ1RSTF9BKTsK
------=_Part_5745_20473236.1140615633528
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_5745_20473236.1140615633528--
