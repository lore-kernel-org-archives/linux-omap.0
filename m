From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 39/40] DSPBRIDGE: error code guide
Date: Thu,  3 Jun 2010 00:47:52 -0500
Message-ID: <1275544073-20418-40-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37610 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554Ab0FCF4W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:22 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Document which specifies the uses of kernel error codes within
bridge driver, in some case it also contains a common use case
were the error might be seen.

It was generated from a previously deleted errbase.h file.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 Documentation/tidspbridge/error-codes |  157 +++++++++++++++++++++++++++++++++
 1 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/tidspbridge/error-codes

diff --git a/Documentation/tidspbridge/error-codes b/Documentation/tidspbridge/error-codes
new file mode 100644
index 0000000..12826e2
--- /dev/null
+++ b/Documentation/tidspbridge/error-codes
@@ -0,0 +1,157 @@
+			DSP/Bridge Error Code Guide
+
+
+Success code is always taken as 0, except for one case where a success status
+different than 0 can be possible, this is when enumerating a series of dsp
+objects, if the enumeration doesn't have any more objects it is considered as a
+successful case. In this case a positive ENODATA is returned (TODO: Change to
+avoid this case).
+
+Error codes are returned as a negative 1, if an specific code is expected, it
+can be propagated to user space by reading errno symbol defined in errno.h, for
+specific details on the implementation a copy of the standard used should be
+read first.
+
+The error codes used by this driver are:
+
+[EPERM]
+    General driver failure.
+
+    According to the use case the following might apply:
+    - Device is in 'sleep/suspend' mode due to DPM.
+    - User cannot mark end of stream on an input channel.
+    - Requested operation is invalid for the node type.
+    - Invalid alignment for the node messaging buffer.
+    - The specified direction is invalid for the stream.
+    - Invalid stream mode.
+
+[ENOENT]
+    The specified object or file was not found.
+
+[ESRCH]
+    A shared memory buffer contained in a message or stream could not be mapped
+    to the GPP client process's virtual space.
+
+[EIO]
+    Driver interface I/O error.
+
+    or:
+    - Unable to plug channel ISR for configured IRQ.
+    - No free I/O request packets are available.
+
+[ENXIO]
+    Unable to find a named section in DSP executable or a non-existent memory
+    segment identifier was specified.
+
+[EBADF]
+    General error for file handling:
+
+    - Unable to open file.
+    - Unable to read file.
+    - An error occurred while parsing the DSP executable file.
+
+[ENOMEM]
+    A memory allocation failure occurred.
+
+[EACCES]
+    - Unable to read content of DCD data section; this is typically caused by
+    improperly configured nodes.
+    - Unable to decode DCD data section content; this is typically caused by
+    changes to DSP/BIOS Bridge data structures.
+    - Unable to get pointer to DCD data section; this is typically caused by
+    improperly configured UUIDs.
+    - Unable to load file containing DCD data section; this is typically
+    caused by a missing COFF file.
+    - The specified COFF file does not contain a valid node registration
+    section.
+
+[EFAULT]
+    Invalid pointer or handler.
+
+[EEXIST]
+    Attempted to create a channel manager  when one already exists.
+
+[EINVAL]
+    Invalid argument.
+
+[ESPIPE]
+    Symbol not found in the COFF file.  DSPNode_Create will return this if
+    the iAlg function table for an xDAIS socket is not found in the COFF file.
+    In this case, force the symbol to be linked into the COFF file.
+    DSPNode_Create, DSPNode_Execute, and DSPNode_Delete will return this if
+    the create, execute, or delete phase function, respectively, could not be
+    found in the COFF file.
+
+    - No symbol table is loaded/found for this board.
+    - Unable to initialize the ZL COFF parsing module.
+
+[EPIPE]
+    I/O is currently pending.
+
+    - End of stream was already requested on this output channel.
+
+[EDOM]
+    A parameter is specified outside its valid range.
+
+[ENOSYS]
+    The indicated operation is not supported.
+
+[EIDRM]
+    During enumeration a change in the number or properties of the objects
+    has occurred.
+
+[ECHRNG]
+    Attempt to created channel manager with too many channels or channel ID out
+    of range.
+
+[EBADR]
+    The state of the specified object is incorrect for the requested operation.
+
+    - Invalid segment ID.
+
+[ENODATA]
+    Unable to retrieve resource information from the registry.
+
+    - No more registry values.
+
+[ETIME]
+    A timeout occurred before the requested operation could complete.
+
+[ENOSR]
+    A stream has been issued the maximum number of buffers allowed in the
+    stream at once; buffers must be reclaimed from the stream before any more
+    can be issued.
+
+    - No free channels are available.
+
+[EILSEQ]
+    Error occurred in a dynamic loader library function.
+
+[EISCONN]
+    The Specified Connection already exists.
+
+[ENOTCONN]
+    Nodes not connected.
+
+[ETIMEDOUT]
+    Timeout occurred waiting for a response from the hardware.
+
+    - Wait for flush operation on an output channel timed out.
+
+[ECONNREFUSED]
+    No more connections can be made for this node.
+
+[EALREADY]
+    Channel is already in use.
+
+[EREMOTEIO]
+    dwTimeOut parameter was CHNL_IOCNOWAIT, yet no I/O completions were
+    queued.
+
+[ECANCELED]
+    I/O has been cancelled on this channel.
+
+[ENOKEY]
+    Invalid subkey parameter.
+
+    - UUID not found in registry.
-- 
1.7.1

