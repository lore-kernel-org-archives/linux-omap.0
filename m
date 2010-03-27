From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH v1 0/19] Cleanup- custom error codes
Date: Sat, 27 Mar 2010 07:56:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEE06@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_19F8576C6E063C45BE387C64729E7394044DEBEE06dbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39497 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab0C0C0z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Mar 2010 22:26:55 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

--_002_19F8576C6E063C45BE387C64729E7394044DEBEE06dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


This RFC v1 patch series fixes Exxxx to -Exxxxx

Dsp_status replacement will be sent out as separate patch.


As of today there are around 113 DSPBRIDGE specific error codes.

Here are the details:

1. 41 error codes are not currently used in bridge. Hence they can be remov=
ed.

2. 19 error codes are mapped to Linux standard error codes. Patches 1 to 19=
 contains these changes.

3. 7 error codes are used as base address to access the rest of error codes=
 which can be removed. Some base addresses are removed as part of 1 but som=
e are still kept as point 4 has dependency on these addresses.
Ex: (Removed base address)
/* FAILURE Codes: LDR */
#define LDR_EBASE                   (DSP_COMP_EBASE + 0x100)

/* Insufficient memory to export class driver services. */
#define LDR_E_NOMEMORY              (LDR_EBASE + 0x00)

/* Unable to find WMD file in system directory. */
#define LDR_E_FILEUNABLETOOPEN      (LDR_EBASE + 0x01)

4. For 46 error codes, couldn't find an exact match in Linux error code. Th=
is still needs to be worked out. This is not addressed in this patch series=
. (See attached text file for details)

As for as OMX components concerned, they really don't care about the specif=
ic error codes. Hence no changes required for the OMX code.

Shivananda Hebbar (19)

DSPBRIDGE: Cleanup custom error code (DSP_EALREADYCONNECTED ->-EISCONN) DSP=
BRIDGE: Cleanup custom error code (DSP_ECORRUPTFILE ->-EBADF)
DSPBRIDGE: Cleanup custom error code (DSP_EFILE ->-ENOENT)=20
DSPBRIDGE: Cleanup custom error code (DSP_EHANDLE -> -EFAULT)=20
DSPBRIDGE: Cleanup custom error code (DSP_EINVALIDARG -> -EINVAL)=20
DSPBRIDGE: Cleanup custom error code (DSP_ENOMEM -> -ENOMEM)=20
DSPBRIDGE: Cleanup custom error code (DSP_ENODETYPE -> -EPERM)
DSPBRIDGE: Cleanup custom error code (DSP_ENOTIMPL -> -ENOSYS)=20
DSPBRIDGE: Cleanup custom error code (DSP_EFOPEN -> -EBADF)
DSPBRIDGE: Cleanup custom error code (DSP_EPOINTER -> -EFAULT)=20
DSPBRIDGE: Cleanup custom error code (DSP_ERANGE -> -EDOM)
DSPBRIDGE: Cleanup custom error code (DSP_ESIZE -> -EINVAL)
DSPBRIDGE: Cleanup custom error code (DSP_ETIMEOUT -> -ETIME)
DSPBRIDGE: Cleanup custom error code (DSP_EVALUE -> -EINVAL)
DSPBRIDGE: Cleanup custom error code (DSP_EUUID -> -ENOKEY)
DSPBRIDGE: Cleanup custom error code (DSP_ENOTCONNECTED -> -ENOTCONN)
DSPBRIDGE: Cleanup custom error code (CHNL_E_CHANBUSY -> -EALREADY)
DSPBRIDGE: Cleanup custom error code (CHNL_E_CANCELLED -> -ECANCELED)
DSPBRIDGE: Cleanup custom error code (WMD_E_TIMEOUT -> -ETIMEDOUT)

 arch/arm/plat-omap/include/dspbridge/_dcd.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/chnl.h     |   10 +-
 arch/arm/plat-omap/include/dspbridge/cmm.h      |   28 +++---
 arch/arm/plat-omap/include/dspbridge/cod.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/dbdcd.h    |   16 ++--
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |   10 +-
 arch/arm/plat-omap/include/dspbridge/dev.h      |   36 ++++----
 arch/arm/plat-omap/include/dspbridge/disp.h     |   10 +-
 arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/errbase.h  |   58 ------------
 arch/arm/plat-omap/include/dspbridge/io.h       |    6 +-
 arch/arm/plat-omap/include/dspbridge/mgr.h      |    8 +-
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h |    8 +-
 arch/arm/plat-omap/include/dspbridge/node.h     |   86 +++++++++---------
 arch/arm/plat-omap/include/dspbridge/nodepriv.h |    8 +-
 arch/arm/plat-omap/include/dspbridge/ntfy.h     |    8 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |   54 ++++++------
 arch/arm/plat-omap/include/dspbridge/pwr.h      |   10 +-
 arch/arm/plat-omap/include/dspbridge/rmm.h      |    4 +-
 arch/arm/plat-omap/include/dspbridge/strm.h     |   52 +++++-----
 arch/arm/plat-omap/include/dspbridge/sync.h     |   26 +++---
 arch/arm/plat-omap/include/dspbridge/wmd.h      |   78 ++++++++--------
 drivers/dsp/bridge/pmgr/chnl.c                  |    4 +-
 drivers/dsp/bridge/pmgr/cmm.c                   |   34 ++++----
 drivers/dsp/bridge/pmgr/cod.c                   |   16 ++--
 drivers/dsp/bridge/pmgr/dbll.c                  |   24 +++---
 drivers/dsp/bridge/pmgr/dev.c                   |   36 ++++----
 drivers/dsp/bridge/pmgr/dmm.c                   |   10 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |   86 +++++++++---------
 drivers/dsp/bridge/rmgr/dbdcd.c                 |   24 +++---
 drivers/dsp/bridge/rmgr/disp.c                  |    8 +-
 drivers/dsp/bridge/rmgr/drv.c                   |   14 ++--
 drivers/dsp/bridge/rmgr/drv_interface.c         |    2 +-
 drivers/dsp/bridge/rmgr/mgr.c                   |    4 +-
 drivers/dsp/bridge/rmgr/nldr.c                  |   30 +++---
 drivers/dsp/bridge/rmgr/node.c                  |  112 +++++++++++--------=
---
 drivers/dsp/bridge/rmgr/proc.c                  |   56 ++++++------
 drivers/dsp/bridge/rmgr/pwr.c                   |    4 +-
 drivers/dsp/bridge/rmgr/rmm.c                   |   14 ++--
 drivers/dsp/bridge/rmgr/strm.c                  |   62 ++++++------
 drivers/dsp/bridge/services/cfg.c               |    6 +-
 drivers/dsp/bridge/services/ntfy.c              |   14 ++--
 drivers/dsp/bridge/services/sync.c              |   26 +++---
 drivers/dsp/bridge/wmd/chnl_sm.c                |   56 ++++++------
 drivers/dsp/bridge/wmd/io_sm.c                  |   26 +++---
 drivers/dsp/bridge/wmd/msg_sm.c                 |   32 +++---
 drivers/dsp/bridge/wmd/tiomap3430.c             |   20 ++--
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |    8 +-
 drivers/dsp/bridge/wmd/ue_deh.c                 |    4 +-
 49 files changed, 598 insertions(+), 656 deletions(-)









--_002_19F8576C6E063C45BE387C64729E7394044DEBEE06dbde02enttico_
Content-Type: text/plain; name="Linux_errorcode_match_not_found.txt"
Content-Description: Linux_errorcode_match_not_found.txt
Content-Disposition: attachment;
	filename="Linux_errorcode_match_not_found.txt"; size=5442;
	creation-date="Fri, 26 Mar 2010 06:44:06 GMT";
	modification-date="Fri, 26 Mar 2010 06:48:49 GMT"
Content-Transfer-Encoding: base64

LyogVGhlIHNwZWNpZmllZCBkaXJlY3Rpb24gaXMgaW52YWxpZCAqLw0KI2RlZmluZSBEU1BfRURJ
UkVDVElPTiAgICAgICAgICAgICAgKERTUF9FQkFTRSArIDYpDQoNCi8qIEEgc3RyZWFtIGhhcyBi
ZWVuIGlzc3VlZCB0aGUgbWF4aW11bSBudW1iZXIgb2YgYnVmZmVycyBhbGxvd2VkIGluIHRoZQ0K
ICogc3RyZWFtIGF0IG9uY2UgOyAgYnVmZmVycyBtdXN0IGJlIHJlY2xhaW1lZCBmcm9tIHRoZSBz
dHJlYW0gYmVmb3JlIGFueQ0KICogbW9yZSBjYW4gYmUgaXNzdWVkLiAqLw0KI2RlZmluZSBEU1Bf
RVNUUkVBTUZVTEwgICAgICAgICAgICAgKERTUF9FQkFTRSArIDcpDQoNCi8qIEEgZ2VuZXJhbCBm
YWlsdXJlIG9jY3VycmVkICovDQojZGVmaW5lIERTUF9FRkFJTCAgICAgICAgICAgICAgICAgICAo
RFNQX0VCQVNFICsgOCkiDQoNCi8qIE5vIG1vcmUgY29ubmVjdGlvbnMgY2FuIGJlIG1hZGUgZm9y
IHRoaXMgbm9kZS4gKi8NCiNkZWZpbmUgRFNQX0VOT01PUkVDT05ORUNUSU9OUyAgICAgIChEU1Bf
RUJBU0UgKyAweGYpDQoNCi8qIEEgdGFzayBjcmVhdGlvbiBmYWlsdXJlIG9jY3VycmVkIG9uIHRo
ZSBEU1AuICovDQojZGVmaW5lIERTUF9FVEFTSyAgICAgICAgICAgICAgICAgICAoRFNQX0VCQVNF
ICsgMHgxNikNCg0KLyogVGhlIHN0YXRlIG9mIHRoZSBzcGVjaWZpZWQgb2JqZWN0IGlzIGluY29y
cmVjdCBmb3IgdGhlIHJlcXVlc3RlZA0KICogb3BlcmF0aW9uLiAqLw0KI2RlZmluZSBEU1BfRVdS
T05HU1RBVEUgICAgICAgICAgICAgKERTUF9FQkFTRSArIDB4MWIpDQoNCi8qIFN5bWJvbCBub3Qg
Zm91bmQgaW4gdGhlIENPRkYgZmlsZS4gIA0KI2RlZmluZSBEU1BfRVNZTUJPTCAgICAgICAgICAg
ICAgICAgKERTUF9FQkFTRSArIDB4MWMpDQoNCi8qIFVuYWJsZSB0byByZWFkIGNvbnRlbnQgb2Yg
RENEIGRhdGEgc2VjdGlvbiA7IHRoaXMgaXMgdHlwaWNhbGx5IGNhdXNlZCBieQ0KICogaW1wcm9w
ZXJseSBjb25maWd1cmVkIG5vZGVzLiAqLw0KI2RlZmluZSBEU1BfRURDRFJFQURTRUNUICAgICAg
ICAgICAgKERTUF9FQkFTRSArIDB4MWUpDQoNCi8qIFVuYWJsZSB0byBkZWNvZGUgRENEIGRhdGEg
c2VjdGlvbiBjb250ZW50IDsgdGhpcyBpcyB0eXBpY2FsbHkgY2F1c2VkIGJ5DQogKiBjaGFuZ2Vz
IHRvIERTUC9CSU9TIEJyaWRnZSBkYXRhIHN0cnVjdHVyZXMuICovDQojZGVmaW5lIERTUF9FRENE
UEFSU0VTRUNUICAgICAgICAgICAoRFNQX0VCQVNFICsgMHgxZikNCg0KLyogVW5hYmxlIHRvIGdl
dCBwb2ludGVyIHRvIERDRCBkYXRhIHNlY3Rpb24gOyB0aGlzIGlzIHR5cGljYWxseSBjYXVzZWQg
YnkNCiAqIGltcHJvcGVybHkgY29uZmlndXJlZCBVVUlEcy4gKi8NCiNkZWZpbmUgRFNQX0VEQ0RH
RVRTRUNUICAgICAgICAgICAgIChEU1BfRUJBU0UgKyAweDIwKQ0KDQovKiBVbmFibGUgdG8gbG9h
ZCBmaWxlIGNvbnRhaW5pbmcgRENEIGRhdGEgc2VjdGlvbiA7IHRoaXMgaXMgdHlwaWNhbGx5DQog
KiBjYXVzZWQgYnkgYSBtaXNzaW5nIENPRkYgZmlsZS4gKi8NCiNkZWZpbmUgRFNQX0VEQ0RMT0FE
QkFTRSAgICAgICAgICAgIChEU1BfRUJBU0UgKyAweDIxKQ0KDQovKiBBIHNwZWNpZmllZCBlbnRp
dHkgd2FzIG5vdCBmb3VuZC4gICovDQojZGVmaW5lIERTUF9FTk9URk9VTkQgICAgICAgICAgICAg
ICAoRFNQX0VCQVNFICsgMHgyZCkNCg0KLyogQSBzaGFyZWQgbWVtb3J5IGJ1ZmZlciBjb250YWlu
ZWQgaW4gYSBtZXNzYWdlIG9yIHN0cmVhbSBjb3VsZCBub3QgYmUNCiAqIG1hcHBlZCB0byB0aGUg
R1BQIGNsaWVudCBwcm9jZXNzJ3MgdmlydHVhbCBzcGFjZS4gKi8NCiNkZWZpbmUgRFNQX0VUUkFO
U0xBVEUgICAgICAgICAgICAgIChEU1BfRUJBU0UgKyAweDJmKQ0KDQovKiBVbmFibGUgdG8gZmlu
ZCBhIG5hbWVkIHNlY3Rpb24gaW4gRFNQIGV4ZWN1dGFibGUgKi8NCiNkZWZpbmUgRFNQX0VOT1NF
Q1QgICAgICAgICAgICAgICAgIChEU1BfRUJBU0UgKyAweDMyKQ0KDQovKiBVbmFibGUgdG8gcmVh
ZCBmaWxlICovDQojZGVmaW5lIERTUF9FRlJFQUQgICAgICAgICAgICAgICAgICAoRFNQX0VCQVNF
ICsgMHgzNCkNCg0KLyogQSBub24tZXhpc3RlbnQgbWVtb3J5IHNlZ21lbnQgaWRlbnRpZmllciB3
YXMgc3BlY2lmaWVkICovDQojZGVmaW5lIERTUF9FT1ZFUkxBWU1FTU9SWSAgICAgICAgICAoRFNQ
X0VCQVNFICsgMHgzNykNCg0KLyogSW52YWxpZCBzZWdtZW50IElEICovDQojZGVmaW5lIERTUF9F
QkFEU0VHSUQgICAgICAgICAgICAgICAoRFNQX0VCQVNFICsgMHgzOCkNCg0KLyogSW52YWxpZCBh
bGlnbm1lbnQgKi8NCiNkZWZpbmUgRFNQX0VBTElHTk1FTlQgICAgICAgICAgICAgICAoRFNQX0VC
QVNFICsgMHgzOSkNCg0KLyogSW52YWxpZCBzdHJlYW0gbW9kZSAqLw0KI2RlZmluZSBEU1BfRVNU
Uk1NT0RFICAgICAgICAgICAgICAgKERTUF9FQkFTRSArIDB4M2EpDQoNCi8qIE5vdCBzaGFyZWQg
bWVtb3J5ICovDQojZGVmaW5lIERTUF9FTk9UU0hBUkVETUVNICAgICAgICAgICAoRFNQX0VCQVNF
ICsgMHgzYykNCg0KLyogRXJyb3Igb2NjdXJyZWQgaW4gYSBkeW5hbWljIGxvYWRlciBsaWJyYXJ5
IGZ1bmN0aW9uICovDQojZGVmaW5lIERTUF9FRFlOTE9BRCAgICAgICAgICAgICAgICAoRFNQX0VC
QVNFICsgMHgzZCkNCg0KLyogRGV2aWNlIGluICdzbGVlcC9zdXNwZW5kJyBtb2RlIGR1ZSB0byBE
UE0gKi8NCiNkZWZpbmUgRFNQX0VEUE1TVVNQRU5EICAgICAgICAgICAgIChEU1BfRUJBU0UgKyAw
eDNlKQ0KDQovKiBJbnZhbGlkIHBvaW50ZXIgcGFzc2VkIGludG8gYSBjb25maWd1cmF0aW9uIG1v
ZHVsZSBmdW5jdGlvbiAqLw0KI2RlZmluZSBDRkdfRV9JTlZBTElEUE9JTlRFUiAgICAgICAgKENG
R19FQkFTRSArIDB4MDApDQoNCi8qIEludmFsaWQgZGV2aWNlIG5vZGUgaGFuZGxlIHBhc3NlZCBp
bnRvIGEgY29uZmlndXJhdGlvbiBtb2R1bGUgZnVuY3Rpb24uICovDQojZGVmaW5lIENGR19FX0lO
VkFMSURIREVWTk9ERSAgICAgICAoQ0ZHX0VCQVNFICsgMHgwMSkNCg0KLyogVW5hYmxlIHRvIHJl
dHJpZXZlIHJlc291cmNlIGluZm9ybWF0aW9uIGZyb20gdGhlIHJlZ2lzdHJ5LiAqLw0KI2RlZmlu
ZSBDRkdfRV9SRVNPVVJDRU5PVEFWQUlMICAgICAgKENGR19FQkFTRSArIDB4MDIpDQoNCi8qIE5v
IHN5bWJvbCB0YWJsZSBpcyBsb2FkZWQgZm9yIHRoaXMgYm9hcmQuICovDQojZGVmaW5lIENPRF9F
X05PU1lNQk9MU0xPQURFRCAgICAgICAoQ09EX0VCQVNFICsgMHgwMCkNCg0KLyogU3ltYm9sIG5v
dCBmb3VuZCBpbiBmb3IgdGhpcyBib2FyZC4gKi8NCiNkZWZpbmUgQ09EX0VfU1lNQk9MTk9URk9V
TkQgICAgICAgIChDT0RfRUJBU0UgKyAweDAxKQ0KDQovKiBVbmFibGUgdG8gaW5pdGlhbGl6ZSB0
aGUgWkwgQ09GRiBwYXJzaW5nIG1vZHVsZS4gKi8NCiNkZWZpbmUgQ09EX0VfWkxDUkVBVEVGQUlM
RUQgICAgICAgIChDT0RfRUJBU0UgKyAweDAzKQ0KDQovKiBVbmFibGUgdG8gb3BlbiBEU1AgZXhl
Y3V0YWJsZSBDT0ZGIGZpbGUuICovDQojZGVmaW5lIENPRF9FX09QRU5GQUlMRUQgICAgICAgICAg
ICAoQ09EX0VCQVNFICsgMHgwNCkNCg0KLyogQXR0ZW1wdCB0byBjcmVhdGVkIGNoYW5uZWwgbWFu
YWdlciB3aXRoIHRvbyBtYW55IGNoYW5uZWxzLiAqLw0KI2RlZmluZSBDSE5MX0VfTUFYQ0hBTk5F
TFMgICAgICAgICAgKENITkxfRUJBU0UgKyAweDAwKQ0KDQovKiBObyBmcmVlIGNoYW5uZWxzIGFy
ZSBhdmFpbGFibGUuICovDQojZGVmaW5lIENITkxfRV9PVVRPRlNUUkVBTVMgICAgICAgICAoQ0hO
TF9FQkFTRSArIDB4MDIpDQoNCi8qIENoYW5uZWwgSUQgaXMgb3V0IG9mIHJhbmdlLiAqLw0KI2Rl
ZmluZSBDSE5MX0VfQkFEQ0hBTklEICAgICAgICAgICAgKENITkxfRUJBU0UgKyAweDAzKQ0KDQov
KiBkd1RpbWVPdXQgcGFyYW1ldGVyIHdhcyBDSE5MX0lPQ05PV0FJVCwgeWV0IG5vIEkvTyBjb21w
bGV0aW9ucyB3ZXJlDQogKiBxdWV1ZWQuICovDQojZGVmaW5lIENITkxfRV9OT0lPQyAgICAgICAg
ICAgICAgICAoQ0hOTF9FQkFTRSArIDB4MDYpDQoNCi8qIEVuZCBvZiBzdHJlYW0gd2FzIGFscmVh
ZHkgcmVxdWVzdGVkIG9uIHRoaXMgb3V0cHV0IGNoYW5uZWwuICovDQojZGVmaW5lIENITkxfRV9F
T1MgICAgICAgICAgICAgICAgICAoQ0hOTF9FQkFTRSArIDB4MDkpDQoNCi8qIERTUCB3b3JkIHNp
emUgb2YgemVybyBjb25maWd1cmVkIGZvciB0aGlzIGRldmljZS4gKi8NCiNkZWZpbmUgQ0hOTF9F
X0lOVkFMSURXT1JEU0laRSAgICAgIChDSE5MX0VCQVNFICsgMHgwRCkNCg0KLyogQSB6ZXJvIGxl
bmd0aCBtZW1vcnkgYmFzZSB3YXMgc3BlY2lmaWVkIGZvciBhIHNoYXJlZCBtZW1vcnkgY2xhc3Mg
ZHJpdmVyLiAqLw0KI2RlZmluZSBDSE5MX0VfSU5WQUxJRE1FTUJBU0UgICAgICAgKENITkxfRUJB
U0UgKyAweDBFKQ0KDQovKiBNZW1vcnkgbWFwIGlzIG5vdCBjb25maWd1cmVkLCBvciB1bmFibGUg
dG8gbWFwIHBoeXNpY2FsIHRvIGxpbmVhcg0KICogYWRkcmVzcy4gKi8NCiNkZWZpbmUgQ0hOTF9F
X05PTUVNTUFQICAgICAgICAgICAgIChDSE5MX0VCQVNFICsgMHgwRikNCg0KLyogQXR0ZW1wdGVk
IHRvIGNyZWF0ZSBhIGNoYW5uZWwgbWFuYWdlciAgd2hlbiBvbmUgYWxyZWFkeSBleGlzdHMuICov
DQojZGVmaW5lIENITkxfRV9NR1JFWElTVFMgICAgICAgICAgICAoQ0hOTF9FQkFTRSArIDB4MTAp
DQoNCi8qIFVuYWJsZSB0byBwbHVnIGNoYW5uZWwgSVNSIGZvciBjb25maWd1cmVkIElSUS4gKi8N
CiNkZWZpbmUgQ0hOTF9FX0lTUiAgICAgICAgICAgICAgICAgIChDSE5MX0VCQVNFICsgMHgxMSkN
Cg0KLyogTm8gZnJlZSBJL08gcmVxdWVzdCBwYWNrZXRzIGFyZSBhdmFpbGFibGUuICovDQojZGVm
aW5lIENITkxfRV9OT0lPUlBTICAgICAgICAgICAgICAoQ0hOTF9FQkFTRSArIDB4MTIpDQoNCi8q
IEJ1ZmZlciBzaXplIGlzIGxhcmdlciB0aGFuIHRoZSBzaXplIG9mIHBoeXNpY2FsIGNoYW5uZWwu
IA0KKi8jZGVmaW5lIENITkxfRV9CVUZTSVpFICAgICAgICAgICAgICAoQ0hOTF9FQkFTRSArIDB4
MTMpDQoNCi8qIFVzZXIgY2Fubm90IG1hcmsgZW5kIG9mIHN0cmVhbSBvbiBhbiBpbnB1dCBjaGFu
bmVsLiANCiovI2RlZmluZSBDSE5MX0VfTk9FT1MgICAgICAgICAgICAgICAgKENITkxfRUJBU0Ug
KyAweDE0KQ0KDQovKiBXYWl0IGZvciBmbHVzaCBvcGVyYXRpb24gb24gYW4gb3V0cHV0IGNoYW5u
ZWwgdGltZWQgb3V0LiANCiovI2RlZmluZSBDSE5MX0VfV0FJVFRJTUVPVVQgICAgICAgICAgKENI
TkxfRUJBU0UgKyAweDE1KQ0KDQovKiBJbnZhbGlkIHN1YmtleSBwYXJhbWV0ZXIuIA0KKi8jZGVm
aW5lIFJFR19FX0lOVkFMSURTVUJLRVkgICAgICAgICAoUkVHX0VCQVNFICsgMHgwMCkNCg0KLyog
Tm8gbW9yZSByZWdpc3RyeSB2YWx1ZXMuDQoqLyNkZWZpbmUgUkVHX0VfTk9NT1JFSVRFTVMgICAg
ICAgICAgIChSRUdfRUJBU0UgKyAweDAyKQ0K

--_002_19F8576C6E063C45BE387C64729E7394044DEBEE06dbde02enttico_--
