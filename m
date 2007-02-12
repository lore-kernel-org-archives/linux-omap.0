From: Kevin Hilman <khilman@mvista.com>
Subject: Re: OMAP1 realtime patch
Date: Mon, 12 Feb 2007 11:32:56 -0800
Message-ID: <1171308776.20717.38.camel@vence.hilman.org>
References: <45C785A4.6080007@googlemail.com>
	<1170882015.11368.25.camel@vence.hilman.org>
	<45CB6775.7020500@googlemail.com>  <45CF4BD1.6010109@googlemail.com>
	<1171308270.20717.32.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-mlV/eNV/tWjM9LV+CEbp"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1171308270.20717.32.camel@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--=-mlV/eNV/tWjM9LV+CEbp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2007-02-12 at 11:24 -0800, Kevin Hilman wrote:
> On Sun, 2007-02-11 at 18:01 +0100, Dirk Behme wrote:
> > Dirk Behme wrote:
> > > Kevin Hilman wrote:
> > > 
> > >> Here is a patch which leaves out the raw_spinlock conversions.  It goes
> > >> on the OMAP git tree on top of -rt5 (ignoring conflicts.)  I've left out
> > >> all the raw_spinlock conversions.  This has been tested on an
> > >> OMAP1623/H2 platform.
> > > 
> > > Update of Kevins update. Tested on OSK.
> > > 
> > > Changes:
> > > 
> > > - Remove kernel/printk.c "+    zap_rt_locks();". It's already in -rt5.
> > > 
> > > - Re-add HRTIMER conversion to ads7846.c
> > > 
> > > With this patch I get Oops below after playing mp3 via NFS. Add 
> > > raw_spinlock_t to sound/arm/omap/omap-alsa-dma.c like in my original 
> > > patch doesn't seem to help.
> > 
> > Re-adding raw_spinlock_t to omap-alsa.h helps against this Oops.
> 
> My guess the oops you sent is that you saw this crash when doing a
> Ctrl-C or otherwise stopping the playback, correct?
> 
> This oops is triggered by the same thread trying to take the same
> spinlock (now an rt_mutex under PREEMPT_RT.)  The following patch
> fixes the nested spinlocks,  and removes the raw_spinlock.  It applies
> on top of your latest patch.
> 
> On my OSK, I do notice however that using -rt (with and without this
> fix) mp3 playback has some audible noise under PREEMPT_RT.  Do you hear
> this too?

This time with the patch.

Another data point...  I only hear the noise when using mpg123 to play
an .mp3 file.  If I use aplay to play a .wav file, I'm not hearing any
noise.  I can even ping flood the target and audio plays without
problems.

Kevin



--=-mlV/eNV/tWjM9LV+CEbp
Content-Disposition: attachment; filename=omap-alsa-rt.patch
Content-Type: text/x-patch; name=omap-alsa-rt.patch; charset=utf-8
Content-Transfer-Encoding: base64

SW5kZXg6IGRldi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL29tYXAtYWxzYS5oDQo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09DQotLS0gZGV2Lm9yaWcvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9vbWFwLWFsc2EuaA0K
KysrIGRldi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL29tYXAtYWxzYS5oDQpAQCAtODMsNyAr
ODMsNyBAQCBzdHJ1Y3QgYXVkaW9fc3RyZWFtIHsNCiAJaW50IGFjdGl2ZToxOwkJLyogd2UgYXJl
IHVzaW5nIHRoaXMgc3RyZWFtIGZvciB0cmFuc2ZlciBub3cgKi8NCiAJaW50IHBlcmlvZDsJCS8q
IGN1cnJlbnQgdHJhbnNmZXIgcGVyaW9kICovDQogCWludCBwZXJpb2RzOwkJLyogY3VycmVudCBj
b3VudCBvZiBwZXJpb2RzIHJlZ2lzdGVyZCBpbiB0aGUgRE1BIGVuZ2luZSAqLw0KLQlyYXdfc3Bp
bmxvY2tfdCBkbWFfbG9jazsJLyogZm9yIGxvY2tpbmcgaW4gRE1BIG9wZXJhdGlvbnMgKi8NCisJ
c3BpbmxvY2tfdCBkbWFfbG9jazsJLyogZm9yIGxvY2tpbmcgaW4gRE1BIG9wZXJhdGlvbnMgKi8N
CiAJc25kX3BjbV9zdWJzdHJlYW1fdCAqc3RyZWFtOwkvKiB0aGUgcGNtIHN0cmVhbSAqLw0KIAl1
bnNpZ25lZCBsaW5rZWQ6MTsJLyogZG1hIGNoYW5uZWxzIGxpbmtlZCAqLw0KIAlpbnQgb2Zmc2V0
OwkJLyogc3RvcmUgc3RhcnQgcG9zaXRpb24gb2YgdGhlIGxhc3QgcGVyaW9kIGluIHRoZSBhbHNh
IGJ1ZmZlciAqLw0KSW5kZXg6IGRldi9zb3VuZC9hcm0vb21hcC9vbWFwLWFsc2EuYw0KPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KLS0tIGRldi5vcmlnL3NvdW5kL2FybS9vbWFwL29tYXAtYWxzYS5jDQorKysgZGV2L3Nv
dW5kL2FybS9vbWFwL29tYXAtYWxzYS5jDQpAQCAtMTY3LDcgKzE2Nyw2IEBAIHN0YXRpYyB2b2lk
IGF1ZGlvX3N0b3BfZG1hKHN0cnVjdCBhdWRpb18NCiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCiAJ
QURFQlVHKCk7DQogDQotCXNwaW5fbG9ja19pcnFzYXZlKCZzLT5kbWFfbG9jaywgZmxhZ3MpOw0K
IAlzLT5hY3RpdmUgPSAwOw0KIAlzLT5wZXJpb2QgPSAwOw0KIAlzLT5wZXJpb2RzID0gMDsNCkBA
IC0xNzYsOCArMTc1LDYgQEAgc3RhdGljIHZvaWQgYXVkaW9fc3RvcF9kbWEoc3RydWN0IGF1ZGlv
Xw0KIAlvbWFwX3N0b3BfYWxzYV9zb3VuZF9kbWEocyk7DQogDQogCW9tYXBfY2xlYXJfYWxzYV9z
b3VuZF9kbWEocyk7DQotDQotCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnMtPmRtYV9sb2NrLCBm
bGFncyk7DQogfQ0KIA0KIC8qDQo=


--=-mlV/eNV/tWjM9LV+CEbp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-mlV/eNV/tWjM9LV+CEbp--
