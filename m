From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [RFC PATCHv2 7/7] HSI CHAR: Update ioctl-number.txt
Date: Fri,  7 May 2010 18:18:37 +0300
Message-ID: <1273245517-30712-8-git-send-email-carlos.chinea@nokia.com>
References: <1273245517-30712-1-git-send-email-carlos.chinea@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273245517-30712-1-git-send-email-carlos.chinea@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Andras Domokos <andras.domokos@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Andras Domokos <andras.domokos@nokia.com>

Added ioctl range for HSI char devices to the documentation

Signed-off-by: Andras Domokos <andras.domokos@nokia.com>
---
 Documentation/ioctl/ioctl-number.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index dd5806f..250e5c5 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -224,6 +224,7 @@ Code  Seq#(hex)	Include File		Comments
 'j'	00-3F	linux/joystick.h
 'k'	00-0F	linux/spi/spidev.h	conflict!
 'k'	00-05	video/kyro.h		conflict!
+'k'	10-17	linux/hsi/hsi_char.h	HSI character device
 'l'	00-3F	linux/tcfs_fs.h		transparent cryptographic file system
 					<http://mikonos.dia.unisa.it/tcfs>
 'l'	40-7F	linux/udf_fs_i.h	in development:
-- 
1.5.6.5
