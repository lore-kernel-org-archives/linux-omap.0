From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/11] ARM: OMAP: Add PARENT_CONTROLS_CLOCK flag to dpll5_m2_ck
Date: Thu,  8 May 2008 15:49:34 -0700
Message-ID: <1210286975-29506-11-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
	<1210286975-29506-1-git-send-email-tony@atomide.com>
	<1210286975-29506-2-git-send-email-tony@atomide.com>
	<1210286975-29506-3-git-send-email-tony@atomide.com>
	<1210286975-29506-4-git-send-email-tony@atomide.com>
	<1210286975-29506-5-git-send-email-tony@atomide.com>
	<1210286975-29506-6-git-send-email-tony@atomide.com>
	<1210286975-29506-7-git-send-email-tony@atomide.com>
	<1210286975-29506-8-git-send-email-tony@atomide.com>
	<1210286975-29506-9-git-send-email-tony@atomide.com>
	<1210286975-29506-10-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1210286975-29506-10-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, =?utf-8?q?H=C3=B6gander=20Jouni?= <jouni.hogander@nokia.com>
List-Id: linux-omap@vger.kernel.org

RnJvbTogSMO2Z2FuZGVyIEpvdW5pIDxqb3VuaS5ob2dhbmRlckBub2tpYS5jb20+CgpUaGlzIHBh
dGNoIHJlbW92ZXMgZm9sbG93aW5nIG1lc3NhZ2Ugb24gZHBsbDVfbTJfY2sgZW5hYmxlIGFuZApk
aXNhYmxlOgoKY2xvY2suYzogRW5hYmxlIGZvciBkcGxsNV9tMl9jayB3aXRob3V0IGVuYWJsZSBj
b2RlCmNsb2NrOiBjbGtfZGlzYWJsZSBjYWxsZWQgb24gaW5kZXBlbmRlbnQgY2xvY2sgZHBsbDVf
bTJfY2sKd2hpY2ggaGFzIG5vIGVuYWJsZV9yZWcKClNpZ25lZC1vZmYtYnk6IEpvdW5pIEhvZ2Fu
ZGVyIDxqb3VuaS5ob2dhbmRlckBub2tpYS5jb20+CkFja2VkLWJ5OiBQYXVsIFdhbG1zbGV5IDxw
YXVsQHB3c2FuLmNvbT4KU2lnbmVkLW9mZi1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRl
LmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL2Nsb2NrMzR4eC5oIHwgICAgMyArKy0KIDEg
ZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtb21hcDIvY2xvY2szNHh4LmggYi9hcmNoL2FybS9tYWNoLW9tYXAy
L2Nsb2NrMzR4eC5oCmluZGV4IGY4YmRjYzEuLmM5YzU5NzIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJt
L21hY2gtb21hcDIvY2xvY2szNHh4LmgKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9jazM0
eHguaApAQCAtODM2LDcgKzgzNiw4IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrIGRwbGw1X20yX2NrID0g
ewogCS5jbGtzZWxfcmVnCT0gT01BUF9DTV9SRUdBRERSKFBMTF9NT0QsIE9NQVAzNDMwRVMyX0NN
X0NMS1NFTDUpLAogCS5jbGtzZWxfbWFzawk9IE9NQVAzNDMwRVMyX0RJVl8xMjBNX01BU0ssCiAJ
LmNsa3NlbAkJPSBkaXYxNl9kcGxsNV9jbGtzZWwsCi0JLmZsYWdzCQk9IENMT0NLX0lOX09NQVAz
NDMwRVMyIHwgUkFURV9QUk9QQUdBVEVTLAorCS5mbGFncwkJPSBDTE9DS19JTl9PTUFQMzQzMEVT
MiB8IFJBVEVfUFJPUEFHQVRFUyB8CisJCQkJUEFSRU5UX0NPTlRST0xTX0NMT0NLLAogCS5yZWNh
bGMJCT0gJm9tYXAyX2Nsa3NlbF9yZWNhbGMsCiB9OwogCi0tIAoxLjUuMy42CgoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpMaXN0IGFkbWluOiBodHRwOi8vbGlzdHMuYXJtLmxpbnV4Lm9yZy51ay9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwKRkFROiAgICAgICAgaHR0cDovL3d3dy5hcm0ubGludXgub3Jn
LnVrL21haWxpbmdsaXN0cy9mYXEucGhwCkV0aXF1ZXR0ZTogIGh0dHA6Ly93d3cuYXJtLmxpbnV4
Lm9yZy51ay9tYWlsaW5nbGlzdHMvZXRpcXVldHRlLnBocA==
