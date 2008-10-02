From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 3/5 v2] Adds I2C board info for tlvaic23
Date: Thu, 2 Oct 2008 15:04:19 +0530
Message-ID: <dfeb90390810020234w56979720rf678693272188b90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_68196_29538571.1222940059404"
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, troy.kisky@boundarydevices.com
List-Id: linux-omap@vger.kernel.org

------=_Part_68196_29538571.1222940059404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Adding I2C board info required for tlvaic23 i2c chip driver

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap1/board-osk.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 3e766e4..e506aef 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -258,8 +258,10 @@ static struct i2c_board_info __initdata
osk_i2c_board_info[] = {
 		.platform_data	= &tps_board,

 	},
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1B),
+	},
 	/* TODO when driver support is ready:
-	 *  - aic23 audio chip at 0x1a
 	 *  - on Mistral, 24c04 eeprom at 0x50
 	 *  - optionally on Mistral, ov9640 camera sensor at 0x30
 	 */
-- 
1.5.3.4

------=_Part_68196_29538571.1222940059404
Content-Type: text/x-patch;
 name=0003-Adds-I2C-board-info-for-tlvaic23.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_flt6y9ho0
Content-Disposition: attachment;
 filename=0003-Adds-I2C-board-info-for-tlvaic23.patch

RnJvbSA0ZmEzOGNlMWJmZjQwMzAxNTFkYjIwODFiNmZkYzJlZDRmM2UxMmZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IFR1ZSwgMzAgU2VwIDIwMDggMTM6MjM6MTkgKzA1MzAKU3ViamVjdDogW1BBVENIXSBB
ZGRzIEkyQyBib2FyZCBpbmZvIGZvciB0bHZhaWMyMwoKQWRkaW5nIEkyQyBib2FyZCBpbmZvIHJl
cXVpcmVkIGZvciB0bHZhaWMyMyBpMmMgY2hpcCBkcml2ZXIKClNpZ25lZC1vZmYtYnk6IEFydW4g
S1MgPGFydW5rc0BtaXN0cmFsc29sdXRpb25zLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAx
L2JvYXJkLW9zay5jIHwgICAgNCArKystCiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAxL2JvYXJk
LW9zay5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2FyZC1vc2suYwppbmRleCAzZTc2NmU0Li5l
NTA2YWVmIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAxL2JvYXJkLW9zay5jCisrKyBi
L2FyY2gvYXJtL21hY2gtb21hcDEvYm9hcmQtb3NrLmMKQEAgLTI1OCw4ICsyNTgsMTAgQEAgc3Rh
dGljIHN0cnVjdCBpMmNfYm9hcmRfaW5mbyBfX2luaXRkYXRhIG9za19pMmNfYm9hcmRfaW5mb1td
ID0gewogCQkucGxhdGZvcm1fZGF0YQk9ICZ0cHNfYm9hcmQsCiAKIAl9LAorCXsKKwkJSTJDX0JP
QVJEX0lORk8oInRsdjMyMGFpYzIzIiwgMHgxQiksCisJfSwKIAkvKiBUT0RPIHdoZW4gZHJpdmVy
IHN1cHBvcnQgaXMgcmVhZHk6Ci0JICogIC0gYWljMjMgYXVkaW8gY2hpcCBhdCAweDFhCiAJICog
IC0gb24gTWlzdHJhbCwgMjRjMDQgZWVwcm9tIGF0IDB4NTAKIAkgKiAgLSBvcHRpb25hbGx5IG9u
IE1pc3RyYWwsIG92OTY0MCBjYW1lcmEgc2Vuc29yIGF0IDB4MzAKIAkgKi8KLS0gCjEuNS4zLjQK
Cg==
------=_Part_68196_29538571.1222940059404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_68196_29538571.1222940059404--
