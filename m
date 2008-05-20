From: Kevin Hilman <khilman@mvista.com>
Subject: [RFC/PATCH 4/5] RT: ARM: disable duplicate cmpxchg
Date: Tue, 20 May 2008 15:45:48 -0700
Message-ID: <1211323550-5318-4-git-send-email-khilman@mvista.com>
References: <1211323550-5318-1-git-send-email-khilman@mvista.com>
 <1211323550-5318-2-git-send-email-khilman@mvista.com>
 <1211323550-5318-3-git-send-email-khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <1211323550-5318-3-git-send-email-khilman@mvista.com>
In-Reply-To: <483353F0.6090902@mvista.com>
References: <483353F0.6090902@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>
List-Id: linux-omap@vger.kernel.org

FIXME: The ARM cmpxchg macro conflicts with the generic ones from
cmpxchg-local.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 include/asm-arm/atomic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-arm/atomic.h b/include/asm-arm/atomic.h
index b5ba735..7cdc2fd 100644
--- a/include/asm-arm/atomic.h
+++ b/include/asm-arm/atomic.h
@@ -146,7 +146,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr,
 		return wrong_size_cmpxchg(ptr);
 }
 
-#define cmpxchg(ptr,o,n)						\
+#define cmpxchg__disabled(ptr,o,n)						\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
-- 
1.5.4.1.166.g6706d

