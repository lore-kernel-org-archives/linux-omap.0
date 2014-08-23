From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/9] use c99 initializers in structures
Date: Sat, 23 Aug 2014 13:20:22 +0200
Message-ID: <1408792831-25615-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: dri-devel@lists.freedesktop.org
Cc: devel@driverdev.osuosl.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, rtc-linux@googlegroups.com, linux-nfc@lists.01.org, kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org, josh@joshtriplett.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

These patches add labels in the initializations of structure fields (c99
initializers).  The complete semantic patch thta makes this change is shown
below.  This rule ignores cases where the initialization is just 0 or NULL,
where some of the fields already use labels, and where there are nested
structures.

// <smpl>
@ok1@
identifier i1,i2;
position p;
@@

struct i1 i2@p = { \(0\|NULL\) };

@ok2@
identifier i1,i2,i3;
position p;
expression e;
@@

struct i1 i2@p = { ..., .i3 = e, ... };

@ok3@
identifier i1,i2;
position p;
@@

struct i1 i2@p = { ..., { ... }, ... };

@decl@
identifier i1,fld;
type T;
field list[n] fs;
@@

struct i1 {
 fs
 T fld;
 ...};

@bad@
identifier decl.i1,i2;
expression e;
position p != {ok1.p,ok2.p,ok3.p};
constant nm;
initializer list[decl.n] is;
position fix;
@@

struct i1 i2@p = { is,
(
 nm(...)
|
 e@fix
)
 ,...};

@@
identifier decl.i1,i2,decl.fld;
expression e;
position bad.p, bad.fix;
@@

struct i1 i2@p = { ...,
+ .fld = e
- e@fix
 ,...};
// </smpl>
