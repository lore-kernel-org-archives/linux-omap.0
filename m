From: Pavel Machek <pavel@ucw.cz>
Subject: new binutils needed for arm in  3.12-rc1
Date: Tue, 24 Sep 2013 01:59:17 +0200
Message-ID: <20130923235917.GA30967@amd.pavel.ucw.cz>
References: <20130919093002.GA23806@amd.pavel.ucw.cz>
 <20130919093627.GB24866@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130919093627.GB24866@mudshark.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Trivial patch monkey <trivial@kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

During 3.12-rc, Will Deacon introduced code into arch/arm that
requires binutils 2.22.
    
Signed-off-by: Pavel Machek <pavel@ucw.cz>
    
---
    
Or that changes should be reverted. I have updated my buildsystem on main
machine, but ... it seems that debian-cross repository does not
contain new enough bintuils for kernel now. We are talking
    
    62cbbc42e0019aff6310259f275ae812463f8836
    6af396a6b6c698eb3834184518fc9a59bc22c817
    73a6fdc48bf52e93c26874dc8c0f0f8d5585a809
    6abdd491698a27f7df04a32ca12cc453810e4396

diff --git a/Documentation/Changes b/Documentation/Changes
index b175808..0f8deaf 100644
--- a/Documentation/Changes
+++ b/Documentation/Changes
@@ -23,7 +23,7 @@ you probably needn't concern yourself with isdn4k-utils.
 
 o  Gnu C                  3.2                     # gcc --version
 o  Gnu make               3.80                    # make --version
-o  binutils               2.12                    # ld -v
+o  binutils               2.22                    # ld -v
 o  util-linux             2.10o                   # fdformat --version
 o  module-init-tools      0.9.10                  # depmod -V
 o  e2fsprogs              1.41.4                  # e2fsck -V

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
