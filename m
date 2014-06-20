From: =?UTF-8?Q?V=C3=ADctor_MV?= <v.mayoralv@gmail.com>
Subject: RT_PREEMPT issue with capemgr: rwlock bad magic on CPU#0
Date: Fri, 20 Jun 2014 17:05:39 +0200
Message-ID: <CAKpQ202W==CaVY0w73n_M-DYb-58P6iVdcRdjh1VA3HLdKbphA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:32864 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbaFTPFk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jun 2014 11:05:40 -0400
Received: by mail-vc0-f182.google.com with SMTP id il7so3536820vcb.41
        for <linux-omap@vger.kernel.org>; Fri, 20 Jun 2014 08:05:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: beagleboard-gsoc@googlegroups.com

Dear developers,

=46ollowing Jason Kridner's advice I'm posting here an issue found whil=
e
working with the BeagleBone and an RT_PREEMPT patched kernel (3.8
taken from https://github.com/beagleboard/kernel/tree/3.8-rt).

The problem seems to be a conflict with the capemgr implemented in the
BeagleBone. Particularly the problem arised when this overlay
(https://github.com/BeaglePilot/ardupilot/blob/master/libraries/AP_HAL_=
Linux/PRU/test_overlays/BB-BONE-PRU-05-00A0.dts)
was loaded but the same behavior has been detected with other overlays
(UART or I2C busses overlays create a similar result):

[ 56.849553] bone-capemgr bone_capemgr.8: part_number
'BB-BONE-PRU-05', version 'N/A'
[ 56.850629] bone-capemgr bone_capemgr.8: slot #4: generic override
[ 56.850661] bone-capemgr bone_capemgr.8: bone: Using override eeprom
data at slot 4
[ 56.850687] bone-capemgr bone_capemgr.8: slot #4: 'Override Board
Name,00A0,Override Manuf,BB-BONE-PRU-05'
[ 56.850866] bone-capemgr bone_capemgr.8: slot #4: Requesting part
number/version based 'BB-BONE-PRU-05-00A0.dtbo
[ 56.850894] bone-capemgr bone_capemgr.8: slot #4: Requesting firmware
'BB-BONE-PRU-05-00A0.dtbo' for board-name 'Override Board Name',
version '00A0'
[ 56.856248] bone-capemgr bone_capemgr.8: slot #4: dtbo
'BB-BONE-PRU-05-00A0.dtbo' loaded; converting to live tree
[ 56.856408] BUG: rwlock bad magic on CPU#0, bash/688, c07021f4
[ 56.862638] [] (unwind_backtrace+0x1/0x8a) from [] (do_raw_read_lock+0=
x13/0x38)
[ 56.872186] [] (do_raw_read_lock+0x13/0x38) from [] (of_resolve+0x27/0=
x370)
[ 56.881348] [] (of_resolve+0x27/0x370) from [] (bone_capemgr_load+0x17=
5/0x408)
[ 56.890787] [] (bone_capemgr_load+0x175/0x408) from []
(slots_store+0x22b/0x26c)
[ 56.900409] [] (slots_store+0x22b/0x26c) from [] (dev_attr_store+0xb/0=
x12)
[ 56.909495] [] (dev_attr_store+0xb/0x12) from [] (sysfs_write_file+0xa=
3/0xda)
[ 56.918847] [] (sysfs_write_file+0xa3/0xda) from [] (vfs_write+0x5d/0x=
100)
[ 56.927910] [] (vfs_write+0x5d/0x100) from [] (sys_write+0x27/0x44)
[ 56.936335] [] (sys_write+0x27/0x44) from [] (ret_fast_syscall+0x1/0x4=
6)
[ 56.948739] bone-capemgr bone_capemgr.8: slot #4: #2 overlays
[ 56.973249] omap_hwmod: pruss: failed to hardreset
[ 56.985351] remoteproc0: 4a300000.prurproc is available
[ 56.998312] remoteproc0: Note: remoteproc is still under development
and considered experimental.
[ 57.018198] remoteproc0: THE BINARY FORMAT IS NOT YET FINALIZED, and
backward compatibility isn't yet guaranteed.
[ 57.030780] pru-rproc 4a300000.prurproc: Loaded OK
[ 57.041467] bone-capemgr bone_capemgr.8: slot #4: Applied #2 overlays.

This behavior is not seen with Vanilla or Xenomai kernels. Reproducing
this issue should be possible grabbing the rt-patched kernel and
loading the overlay.

There's an active discussion about this topic at
https://groups.google.com/forum/#!topic/drones-discuss/7DKcdm0AEPo.

Thanks for your time,

V=C3=ADctor Mayoral Vilches.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
