From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 3/5] RT: ARM: remove __attribute_used__ from semaphore code
Date: Tue, 20 May 2008 15:45:47 -0700
Message-ID: <1211323550-5318-3-git-send-email-khilman@mvista.com>
References: <1211323550-5318-1-git-send-email-khilman@mvista.com>
 <1211323550-5318-2-git-send-email-khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <1211323550-5318-2-git-send-email-khilman@mvista.com>
In-Reply-To: <483353F0.6090902@mvista.com>
References: <483353F0.6090902@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/kernel/semaphore.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/semaphore.c b/arch/arm/kernel/semaphore.c
index 6036f57..11f7d04 100644
--- a/arch/arm/kernel/semaphore.c
+++ b/arch/arm/kernel/semaphore.c
@@ -49,7 +49,7 @@
  *    we cannot lose wakeup events.
  */
 
- void __attribute_used__ __compat_up(struct compat_semaphore *sem)
+ void __used __compat_up(struct compat_semaphore *sem)
 {
 	wake_up(&sem->wait);
 }
@@ -58,7 +58,7 @@ EXPORT_SYMBOL(__compat_up);
 
 static DEFINE_SPINLOCK(semaphore_lock);
 
- void __attribute_used__ __sched __compat_down(struct compat_semaphore * sem)
+ void __used __sched __compat_down(struct compat_semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -93,7 +93,7 @@ static DEFINE_SPINLOCK(semaphore_lock);
 
 EXPORT_SYMBOL(__compat_down);
 
- int __attribute_used__ __sched __compat_down_interruptible(struct compat_semaphore * sem)
+ int __used __sched __compat_down_interruptible(struct compat_semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -154,7 +154,7 @@ EXPORT_SYMBOL(__compat_down_interruptible);
  * single "cmpxchg" without failure cases,
  * but then it wouldn't work on a 386.
  */
- int __attribute_used__ __sched __compat_down_trylock(struct compat_semaphore * sem)
+ int __used __sched __compat_down_trylock(struct compat_semaphore * sem)
 {
 	int sleepers;
 	unsigned long flags;
-- 
1.5.4.1.166.g6706d

